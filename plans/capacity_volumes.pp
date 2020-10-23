# list volumes with more than given capacity
# @param threshold Volume capacity needed (in bytes)
plan powerstore::capacity_volumes(
    TargetSpec              $targets,
    Variant[Numeric,String] $threshold,
){
  $volumes = run_task('powerstore::volume_collection_query', $targets)[0].value
  $rows = $volumes.filter |$k,$v| { $v['size'] > to_bytes($threshold) }.map |$k,$v| {
    [$k, String($v['size'],'%15s'), String(format_bytes($v['size']),'%10s')]
  }
  $volumes_table = format::table({
    title => "List of volumes with capacity > ${threshold}",
    head => ['volume name', 'capacity', 'MB'].map |$field| { format::colorize($field, yellow) },
    rows => $rows
    })
  out::message($volumes_table)
}
