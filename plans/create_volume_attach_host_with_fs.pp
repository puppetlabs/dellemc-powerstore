plan powerstore::create_volume_attach_host_with_fs(
  TargetSpec                $targets,
  String                    $host_name,
  String                    $volume_name,
  String                    $mount_point  = "/mnt/${volume_name}",
  Integer                   $volume_size  = 26843545600,
) {

  # A very quick and dirty implementation that creates a volume on an array
  # attaches the new volume to a host, then on the host scans the SCSI bus
  # for new iSCSI devices, partitions the new device, creates XFS file system,
  # and then mounts the disk

  # Gets the id of the host we want to attach volumes to
  #
  run_task('powerstore::host_collection_query', $targets, {
    'query_string' => "select=name,id&name=eq.${host_name}"
  }).each |$target_result| {
    get_target($target_result.target).set_var('host_id', $target_result.value[$host_name]['id'])
  }

  # Re-use a plan that was used previously to create a fresh volume
  #
  run_plan('powerstore::create_volume', $targets, {
    'volume_name' => $volume_name,
    'size'        => $volume_size,
  }) 

  # Now that volume is created, capture its id for the attach operation and wwn
  # for later use on host
  #
  run_task('powerstore::volume_collection_query', $targets, {
    'query_string' => "select=name,id,wwn&name=eq.${volume_name}"
  }).each |$target_result| {
    get_target($target_result.target).set_var('volume_id', $target_result.value[$volume_name]['id'])
    get_target($target_result.target).set_var('wwn', $target_result.value[$volume_name]['wwn'])
  }

  # For every array we just created a volume on, attach volume to host
  #
  get_targets($targets).each |$target| {
    run_task('powerstore::host_attach', $target, {
      'id'        => vars($target)['host_id'],
      'volume_id' => vars($target)['volume_id']
    })
  }

  # For every array log run the commands on our host that are needed to finish
  # bootstrapping the volume by creating it a mount point, ensure the device
  # has created device nodes for the disks, partition the disk, create a file
  # system, mount the disk, and finally print out `df` output to verify it
  # worked
  #
  get_targets($targets).each |$target| {
    run_command("rescan-scsi-bus.sh", get_target($host_name))

    # Seems to take a second or two for `/dev/disk/by-id` to be populated
    ctrl::sleep(3)
    
    $wwid   = "3${regsubst(vars($target)['wwn'], '^naa.(.*$)', '\1')}"
    $device = "/dev/disk/by-id/dm-uuid-mpath-${wwid}"
    $part   = "/dev/disk/by-id/dm-uuid-part1-mpath-${wwid}"

    $check = run_command("df -h ${part}", get_target($host_name)).first
    
    unless $check.ok {
      run_command("/usr/bin/mkdir -p ${mount_point}", get_target($host_name))
    
      run_command("/usr/sbin/parted ${device} mklabel gpt", get_target($host_name))
      run_command("parted -a optimal ${device} mkpart primary 0% 100%", get_target($host_name))

      run_command("rescan-scsi-bus.sh", get_target($host_name))

      ctrl::sleep(3)
    
      run_command("/usr/sbin/mkfs.xfs ${part}", get_target($host_name))
    
      run_command("/usr/bin/mount ${part} ${mount_point}", get_target($host_name))
    
      $df = run_command("df -h ${mount_point} | tail -1", get_target($host_name)).first.value['stdout']
      out::message($df)
    } else {
      out::message("Volume already mounted on host...skipping...")
    } 
  }
}
