plan powerstore::multi_create_volume_attach_host_with_fs(
  TargetSpec                $targets,
  Array[String[1]]          $hosts,
  String                    $volume_name,
) {

  # Loop over an array of hosts to provision volumes for
  #
  $hosts.each |$host| {
    run_plan('powerstore::create_volume_attach_host_with_fs', $targets, {
      'host_name'   => $host,
      'volume_name' => "${host}-${volume_name}"
    })
  }
}
