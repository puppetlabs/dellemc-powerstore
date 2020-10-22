# This plan deletes multiple volumes
# @param volume_count Number of volumes to delete. The volume names are "vol_${i}" with $i ranging from 1 to $volume_count.
plan powerstore::delete_multiple_volumes(
  TargetSpec $targets,
  Integer[1,100] $volume_count,
){
  apply($targets) {
    Integer[1,$volume_count].each |$i| {
      notice("Deleting volume vol_${i}")
      powerstore_volume { "vol_${i}":
        ensure => absent,
      }
    }
  }
}
