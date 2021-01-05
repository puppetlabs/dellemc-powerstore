# @summary
#   A Bolt Plan that creates a volume, maps that new volume to an existing
#   host, scans that host's iSCSI bus to ensure device nodes have been created,
#   computes the device name as viewed by the host, partitions the new disk
#   device, puts new file system on partition, mounts fresh file system at
#   designated location
#
# @see https://github.com/puppetlabs/dellemc-powerstore
#
# @example Create a volume of the name `db_backups` and mount it upon the host `backup1` with the size of 250GB
#   bolt plan run powerstore::create_volume_attach_host_with_fs --targets powerstore host=backup1 volume_name=db_backups $volume_size=268435456000
#
# @param host_name
#   An host as defined within the Bolt inventory that will be have the new
#   volume mapped to mounted on with file systems created
#
# @param volume_name
#   Name for the new volume that will be created on the powerstore array
#
# @param mount_point
#   Override the default mount point of where the created volume will be
#   mounted on the host once a file system has successfully been created
#
# @param volume_size
#   Override the default size (25G) of the newly created volume
#
plan powerstore::create_volume_attach_host_with_fs(
  TargetSpec                $targets,
  String                    $host_name,
  String                    $volume_name,
  String                    $mount_point  = "/mnt/${volume_name}",
  Integer                   $volume_size  = 26843545600
) {

  # A very quick and dirty implementation that creates a volume on an array
  # attaches the new volume to a host, then on the host scans the SCSI bus
  # for new iSCSI devices, partitions the new device, creates XFS file system,
  # and then mounts the disk

  # Before we go anywhere, ensure we'll be able to complete iSCSI operations on
  # remote hosts
  $package_status = [ 'iscsi-initiator-utils', 'device-mapper-multipath' ].map |$package| {
    run_task('package', get_target($host_name), {
      'name' => $package,
      'action' => 'status',
    }).first.value['status']
  }

  if 'uninstalled' in $package_status {
    fail_plan('Packages iscsi-initiator-utils and device-mapper-multipath must be present on the system for this plan to function')
  }

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
    'size'        => $volume_size
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
    run_command('rescan-scsi-bus.sh', get_target($host_name))

    # Seems to take a second or two for `/dev/disk/by-id` to be populated
    ctrl::sleep(3)

    $wwid   = "3${regsubst(vars($target)['wwn'], '^naa.(.*$)', '\1')}"
    $device = "/dev/disk/by-id/dm-uuid-mpath-${wwid}"
    $part   = "/dev/disk/by-id/dm-uuid-part1-mpath-${wwid}"

    $check = run_command("df -h ${part}", get_target($host_name), '_catch_errors' => true).first

    unless $check.ok {
      run_command("/usr/bin/mkdir -p ${mount_point}", get_target($host_name))

      run_command("/usr/sbin/parted ${device} mklabel gpt", get_target($host_name))
      run_command("parted -a optimal ${device} mkpart primary 0% 100%", get_target($host_name))

      run_command('rescan-scsi-bus.sh', get_target($host_name))

      ctrl::sleep(3)

      run_command("/usr/sbin/mkfs.xfs ${part}", get_target($host_name))

      run_command("/usr/bin/mount ${part} ${mount_point}", get_target($host_name))

      $df = run_command("df -h ${mount_point} | tail -1", get_target($host_name)).first.value['stdout']
      out::message($df)
    } else {
      out::message('Volume already mounted on host...skipping...')
    }
  }
}
