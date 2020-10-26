# @summary
#   A Bolt Plan that creates or deletes a volume
#
# @see https://github.com/puppetlabs/dellemc-powerstore
#
# @example Creates a new volume named `db_backups`
#   bolt plan run powerstore::create_volume --targets powerstore volume_name=db_backups
#
# @param volume_name
#   A name for the new volume
#
# @param size
#   Override the default size (25GB) of the new volume
#
# @param description
#   A simple description to explain the purpose of the volume
#
# @param ensure
#   If the volume should exist or be deleted
#
plan powerstore::create_volume(
  TargetSpec                $targets,
  String                    $volume_name,
  Integer                   $size         = 26843545600,
  String                    $description  = 'Created via Puppet powerstore_volume resource', 
  Enum['present', 'absent'] $ensure       = 'present'
) {


    $results = apply($targets,  '_catch_errors' => true) {
      powerstore_volume { $volume_name:
        ensure      => $ensure,
        size        => $size,
        description => $description,
      }
    }

  return $results
}
