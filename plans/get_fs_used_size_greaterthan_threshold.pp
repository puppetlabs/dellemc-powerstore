# List filesystems using more than $threshold percent of storage. Note: currently limited to one target.
# @param threshold A usage threshold as percentage
# @param format Output format: json (for automation use) or table (human-readable)
plan powerstore::get_fs_used_size_greaterthan_threshold(
  TargetSpec $targets,
  Integer[1,99] $threshold = 90,
  Enum['json','table'] $format = 'table',
){
  # query all available filesystems using a collection query task
  $file_systems = run_task('powerstore::file_system_collection_query', $targets)[0].value

  # filter filesytstems to those with more than $threshold % usage
  $filtered_file_systems = $file_systems.filter | $k, $v | {
    if $v['size_total'] and $v['size_total'] > 0 {
      $v['size_used']*100.0 / $v['size_total'] > $threshold
    }
  }

  # if machine-readable output requested, return a json array of fs names
  if $format == 'json' {
    return $filtered_file_systems.map | $k, $v | { $k }
  }

  # generate human-readable table
  $rows = $filtered_file_systems.map | $k, $v | {
    [$k, String($v['size_used']*100.0 / $v['size_total'], '%0.1f')]
  }
  $usage_table = format::table({
    title => "List of file systems using more than ${threshold}%",
    head => ['file system', 'use %'].map |$field| { format::colorize($field, yellow) },
    rows => $rows
    })
  out::message($usage_table)
}
