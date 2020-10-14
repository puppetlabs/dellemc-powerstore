plan powerstore::volume(
  TargetSpec $targets,
  String $volume_name,
  Integer $size = 26843545600,
  String $description = 'Created via rudimentary task', 
  Enum['present', 'absent'] $ensure = 'present'
) {

  $volumes = Hash(get_resources($targets, 'Powerstore_volume')[0]['resources'].map |$r| { [$r.keys, $r.values] }.flatten)

  apply($targets,  '_catch_errors' => true) {
    powerstore_volume { $volume_name: 
      id => $volumes[$volume_name].empty ? { true => 'bug!', default => $volumes[$volume_name]['id'] },
      size => $size,
      description => $description,
      ensure => $ensure,
    }
  }

  $plan_vol = Hash(get_resources($targets, "Powerstore_volume[${volume_name}]")[0]['resources'].map |$r| { [$r.keys, $r.values] }.flatten)

  return $plan_vol
}
