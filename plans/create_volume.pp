plan powerstore::create_volume(
  TargetSpec                $targets,
  String                    $volume_name,
  Integer                   $size         = 26843545600,
  String                    $description  = 'Created via Puppet powerstore_volume resource', 
  Enum['present', 'absent'] $ensure       = 'present'
) {

  
    $results = apply($targets,  '_catch_errors' => true) {
      powerstore_volume { $volume_name:
        size        => $size,
        description => $description,
        ensure      => $ensure,
      }
    } 

  return $results
}
