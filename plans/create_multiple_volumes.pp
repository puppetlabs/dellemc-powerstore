# This plan creates multiple volumes
# @param volume_count Number of volumes to create. The volume names are "vol_${i}" with $i ranging from 1 to $volume_count.
plan powerstore::create_multiple_volumes(
  TargetSpec $targets,
  Integer[1,100] $volume_count,
){
  # out::message("Creating volume vol_${i}")
  # run_task('powerstore::volume_create', $targets, {name=>"vol_${i}", size=>1048576})
  apply($targets) {
    Integer[1,$volume_count].each |$i| {
      powerstore_volume { "vol_${i}":
        size => 1048576,
      }
    }
  }
}
