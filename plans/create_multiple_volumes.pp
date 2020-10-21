# This plan creates multiple volumes
plan powerstore::create_multiple_volumes(
  TargetSpec $targets,
  Integer[1,100] $volume_count,
){
  Integer[1,$volume_count].each |$i| {
    out::message("Creating volume vol_${i}")
    run_task('powerstore::volume_create', $targets, {name=>"vol_${i}", size=>1048576})
    # apply($targets) {
    #   powerstore_volume { "vol_${i}":
    #     size => 1048576,
    #   }
    # }
  }
}
