# List filesystems whose used_size is greated than threshold
# @param threshold A percentage
plan powerstore::get_fs_used_size_greaterthan_threshold(
  TargetSpec $targets,
  Integer $threshold=90,
){
  $file_systems = run_task('powerstore::file_system_collection_query', $targets)[0].value
  $filtered_file_systems = $file_systems.filter | $k, $v | {
    $v['size_total'] > 0 and $v['size_used'] / $v['size_total'] * 100 > $threshold
  }
  return $filtered_file_systems.map |$k,$v| { $k }
}
