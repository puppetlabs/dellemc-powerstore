# @summary
#   This Bolt Plan makes is possible to create volumes, map them to multiple
#   hosts, create XFS file systems upon them and mount them at a specific
#   location by wrapping another plan that is capable of doing this for a single
#   host
#
# @see https://github.com/puppetlabs/dellemc-powerstore
#
# @example Create a volume of the name `customer_app_database` and mount it upon two hosts, `database1` and `database2`
#   bolt plan run powerstore::multi_create_volume_attach_host_with_fs --targets powerstore hosts='[ "database1", "database2" ]' volume_name=customer_app_database
#
# @param hosts
#   An array of hosts defined within the Bolt inventory that will be have the
#   new volumes mapped to and mounted on with file systems created
#
# @param volume_name
#   A base name of the volumes that will be used to create unique volume names
#   on the powerstore array, actual volume sames end up being of the pattern
#   ${host}_${volume_name}
#
# @param mount_point
#   Override the default mount point of where the created volumes will be
#   mounted on the host once file systems have successfully be created
#
plan powerstore::multi_create_volume_attach_host_with_fs(
  TargetSpec                $targets,
  Array[String[1]]          $hosts,
  String                    $volume_name,
  String                    $mount_point = "/mnt/${volume_name}"
) {

  # Loop over an array of hosts to provision volumes for
  #
  $hosts.each |$host| {
    run_plan('powerstore::create_volume_attach_host_with_fs', $targets, {
      'host_name'   => $host,
      'volume_name' => "${host}-${volume_name}",
      'mount_point' => $mount_point
    })
  }
}
