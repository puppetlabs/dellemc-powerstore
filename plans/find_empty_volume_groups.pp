# List volume groups without assigned volumes
plan powerstore::find_empty_volume_groups(
  TargetSpec $targets,
)
{
  # first, get volume groups with their names and assigned volumes
  # use the query_string task parameter to override the query
  $volume_groups = run_task('powerstore::volume_group_collection_query', $targets, {query_string=>'select=name,volumes'})[0].value

  # now, filter the volume_groups to only those without volumes and take their names
  $empty_volume_groups = $volume_groups.filter |$k, $v| { $v['volumes'].empty }.map |$k, $v| { $k }

  out::message("List of empty volume groups:\n${empty_volume_groups}")
}
