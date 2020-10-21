# List volume groups without assigned volumes
plan powerstore::find_empty_volume_groups(
  TargetSpec $targets,
)
{
  $volume_groups = run_task('powerstore::volume_group_collection_query', $targets, {query_string=>'select=name,volumes'})[0].value
  $empty_volume_groups = $volume_groups.filter |$k, $v| { $v['volumes'].empty }.map |$k, $v| { $k }
  out::message("List of empty volume groups:\n${empty_volume_groups}")
}
