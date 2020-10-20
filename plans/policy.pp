plan powerstore::policy(
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
  # them from the list of all snapshot rules then extracts each rule's ID so
  # it can be assigned to the device target using the set_var() function. We
  # will use this device inventory variable in the next apply block
  #
  # This first line is just running our task using an API collection query and
  # returning a set of results that we'll interate over.
  #   
  run_task('powerstore::snapshot_rule_collection_query', $targets).each |$target_result| {
    # This get_target() line fetches our device's inventory object and calls on
    # it the set_var() function to set the snapshot_rule_ids inventory variable
    #
    get_target($target_result.target).set_var('snapshot_rule_ids',
      # Filter's the resources we got back from the collection query to only
      # include the ones we care about and return their IDs so they are assigned
      # to the correct device
      #
      $target_result.value.filter |$rule| { $rule[0] in $snapshot_rules }.map |$match| { $match[1]['id'] }
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
 
  # Same strategy as with snapshot rules but a tad simpler because we only need
  # to obtain the ID of our policy resource.
  #   
  run_task('powerstore::policy_collection_query', $targets).each |$target_result| {
    get_target($target_result.target).set_var('policy_id',
      $target_result.value.filter |$policy| { $policy[0] == 'default_org_snapshot_set' }.map |$match| { $match[1]['id'] }[0]
    )
  }

  # Update an existing volume with the policy that includes are snapshot rules,
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
  $volumes = Hash(run_task('powerstore::volume_collection_query', $targets).map |$target_result| {
      $target_result.value.filter |$volume| { $volume[0] == $volume_name }.map |$match| {
        [ "${target_result.target.name}_protection_policy_id", $match[1]['protection_policy_id'] ]
      }[0]
    })

  return $volumes
}
