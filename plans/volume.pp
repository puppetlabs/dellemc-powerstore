plan powerstore::volume(
  TargetSpec                $targets,
  String                    $volume_name,
  Integer                   $size         = 26843545600,
  String                    $description  = 'Created via rudimentary task', 
  Enum['present', 'absent'] $ensure       = 'present'
) {

  
  if $ensure == 'absent' {
    $volumes = Hash(run_task('powerstore::volume_collection_query', $targets, {
      'query_string' => "select=id,name&name=eq.${volume_name}" }).map |$target_result| {
        $target_result.value.map |$volume| { [ "${target_result.target.name}", { $volume[0] => $volume[1] } ] }[0]
    })
  
    $results = get_targets($targets).each |$target| {
      run_task('powerstore::volume_delete', $target, {
        'id' => $volumes["${target.name}"][$volume_name]['id']
      })
    } 
  } else {
    $results = run_task('powerstore::volume_create', $targets, {
      'name'        => $volume_name,
      'size'        => $size,
      'description' => $description
    })
  } 

  return $results
}
