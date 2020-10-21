plan powerstore::volume_capacity(
    TargetSpec $targets,
    Integer    $threshold,
){
  $volumes = run_task('powerstore::volume_collection_query', $targets)[0].value
  $rows = $volumes.map |$k,$v| { [$k, $v['size']] }.filter |$e| { $e[1] > $threshold }
  $volumes_table = format::table({
    title => "List of volumes with capacity > ${threshold}",
    head => ['volume name', 'capacity'].map |$field| { format::colorize($field, yellow) },
    rows => $rows
    })
  out::message($volumes_table)
}
