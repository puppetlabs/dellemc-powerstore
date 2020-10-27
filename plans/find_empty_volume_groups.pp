# Find empty volume groups - Puppet language plan example
plan powerstore::find_empty_volume_groups(
  TargetSpec $targets,
){
  # Get volume groups with their names and assigned volumes
  # Use the query_string task parameter to override the query
  $volume_groups = run_task('powerstore::volume_group_collection_query', $targets, 
    {query_string=>'select=name,volumes'}).first.value

  # Filter volume_groups to only those without volumes and take their names
  $empty_volume_groups = $volume_groups.filter |$k, $v| { $v['volumes'].empty }.map |$k, $v| { $v['name'] }

  return $empty_volume_groups
}
