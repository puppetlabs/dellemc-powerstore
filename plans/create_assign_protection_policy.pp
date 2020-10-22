plan powerstore::create_assign_protection_policy(
  TargetSpec                $targets,
  String                    $volume_name,
  Enum['present', 'absent'] $ensure       = 'present'
) {

  # Using an apply() block allows for the re-use of types/providers developed
  # for Puppet from within a Bolt Plan. This re-use makes the development of
  # idempotent plans simpler.
  #
  if $ensure == 'present' {
    apply($targets,  '_catch_errors' => true) {

      $a_week = [
          'Sunday',
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday'
      ]

      powerstore_snapshot_rule { 'high_frequency': 
        interval          => 'Five_Minutes',
        desired_retention => 24,
        days_of_week      => $a_week,
      }
      powerstore_snapshot_rule { 'daily_roll_up': 
        interval          => 'One_Day',
        desired_retention => 168,
        days_of_week      => $a_week,
      }
      powerstore_snapshot_rule { 'weekly_roll_up': 
        time_of_day       => '03:00',
        desired_retention => 2160,
        days_of_week      => [ 'Saturday' ],
      }
    }
  }

  # A simple array of the names of snapshot rules we created previoulsy within
  # this plan
  #
  $snapshot_rules = [ 'high_frequency', 'daily_roll_up', 'weekly_roll_up' ]

  # Task that interrogates the Powerstore devices to retrieve the post apply()
  # state of the snapshot rule resources we preveiously defined by filtering
  # them from the list of all snapshot rules, using an API native query string
  # then extracts each rule's ID so it can be assigned to the device target
  # using the set_var() function. We will use this device inventory variable in
  # the next apply block
  #
  # These first few lines are running the task that uses an API collection query
  # with a custom filter to return a set of results from multiple storage arrays
  # that we'll interate over
  #   
  run_task('powerstore::snapshot_rule_collection_query', $targets, {
    'query_string' => "select=name,id&name=in.(${snapshot_rules.join(',')})"
  }).each |$target_result| {
    # This get_target() line fetches our devices' inventory object and calls on
    # it the set_var() function to set the snapshot_rule_ids inventory variable
    #
    get_target($target_result.target).set_var('snapshot_rule_ids',
      # Use a map() function to transform and collect all the id properties from
      # the resources retruned in our collection query in a single Array
      #
      $target_result.value.map |$rule| { $rule[1]['id'] }
    )
  }

  # An apply() block that creates and associates a policy with our snapshot rule IDs
  #
  if $ensure == 'present' {
    apply($targets, '_catch_errors' => true) {
      powerstore_policy { 'default_org_snapshot_set':
        description       => 'This policy includes the default Snapshot Rules that are applied to volumes for our organization',
        snapshot_rule_ids => $snapshot_rule_ids,
      }
    }
  }

  # Same strategy as with snapshot rules but simpler because we only need to
  # obtain the id of a single known policy resource.
  # 
  run_task('powerstore::policy_collection_query', $targets, {
    'query_string' => 'select=name,id&name=eq.default_org_snapshot_set'
  }).each |$target_result| {
    get_target($target_result.target).set_var('policy_id', $target_result.value['default_org_snapshot_set']['id'])
  }


  # Update an existing volume with the policy that includes out snapshot rules,
  # set it to empty string if the plan is ran with 'ensure=absent'
  #
  apply($targets,  '_catch_errors' => true) {
    powerstore_volume { $volume_name: 
      protection_policy_id => $ensure ? { 'present' => $policy_id, 'absent' => '' }
    }
  }

  # Fetching the volume post apply() block to deliver a visual confirmation that
  # it worked
  #
  # Same strategy as with snapshot rules but a tad simpler because we only need
  # to obtain the ID of our policy resource.
  #   
  $volumes = run_task('powerstore::volume_collection_query', $targets, {
    'query_string' => "select=name,protection_policy_id&name=eq.${volume_name}"
  })

  return $volumes
}
