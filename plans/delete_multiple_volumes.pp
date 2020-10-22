# This plan deletes multiple volumes
# @param volume_count Number of volumes to delete. The volume names are "vol_${i}" with $i ranging from 1 to $volume_count.
plan powerstore::delete_multiple_volumes(
  TargetSpec $targets,
  Integer[1,100] $volume_count,
){
  $volumes = run_task("powerstore::volume_collection_query", $targets, {'query_string' => 'select=*,volume_groups'})[0].value
  
  $volumes_in_group = $volumes.filter | $k, $v | { !$v['volume_groups'].empty }

  Integer[1,$volume_count].each |$i| {
    $volume_name = "vol_${i}"
    $volume_group = $volumes_in_group[$volume_name]
    if $volume_group {
      out::message("Removing volume ${volume_name} from volume group ${$volume_group}")
      run_task('powerstore::volume_group_remove_members', $targets, {'id' => $volume_group['id'], 'volume_ids' => [$volumes[$volume_name]['id']]})
    }
  }
  apply($targets) {
    Integer[1,$volume_count].each |$i| {
      $volume_name = "vol_${i}"
      notice("Deleting volume vol_${i}")
      powerstore_volume { "vol_${i}":
        ensure => absent,
      }
    }
  }
}
