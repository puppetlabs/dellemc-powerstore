plan powerstore::policy(
  TargetSpec $targets,
  String $volume_name,
  Enum['present', 'absent'] $ensure = 'present'
) {

  # Using an apply() block allows for the re-use of types/providers developed
  # for Puppet from within a Bolt Plan. This re-use makies the development of
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
        ensure            => present,
        interval          => 'Five_Minutes',
        desired_retention => 24,
        days_of_week      => $a_week,
      }
      powerstore_snapshot_rule { 'daily_roll_up': 
        ensure            => present,
        interval          => 'One_Day',
        desired_retention => 168,
        days_of_week      => $a_week,
      }
      powerstore_snapshot_rule { 'weekly_roll_up': 
        ensure            => present,
        time_of_day       => '03:00',
        desired_retention => 2160,
        days_of_week      => [ 'Saturday' ],
      }
    }
  }


  # An array of resource references that corresponds to our previously created
  # snapshot rules from the above apply() block...
  #
  $plan_rules = [
    'high_frequency',
    'daily_roll_up',
    'weekly_roll_up'
  ].map |$pr| { "Powerstore_snapshot_rule[${pr}]" }

  # Using the list of resource references use the general purpose
  # get_resources() funtion which has knowledge of device state state and built
  # in filtering to fetch only the resources we previously created so that we
  # extract their IDs which are required to associate with a newly created
  # policy
  #
  $plan_rule_ids = get_resources($targets, $plan_rules).reduce({}) |$memo, $i| {
    $memo + { $i.target.name => Hash($i['resources'].map |$r| {
      [$r.keys, $r.values]
    }.flatten ).map |$k, $v| { $v['id'] } }
  }

  get_targets($targets).each |$e| { $e.set_var('rules', $plan_rule_ids[$e.name]) }

  if $ensure == 'present' {
    apply($targets, '_catch_errors' => true) {
      powerstore_policy { 'default_org_snapshot_set':
        ensure            => present,
        description       => 'This policy includes the default Snapshot Rules that are applied to volumes for our organization',
        snapshot_rule_ids => $rules,
      }
    }
  }
 
  # Same strategy as previous use of get_resources() but simpler because we only
  # need a single ID from a single known resource name that we'll later pass to
  # the volume that needs to be updated.
  #
  $plan_pp_id = get_resources($targets, 'Powerstore_policy[default_org_snapshot_set]')[0]['resources'][0]['default_org_snapshot_set']['id']

  # Same recurring issue with IDs being required for some operations; is
  # is considered a bug that will go away.
  #
  $plan_vol_id = get_resources($targets, "Powerstore_volume[${volume_name}]")[0]['resources'][0][$volume_name]['id']

  # Update an existing volume with the policy that includes are snapshot rules,
  # set it to empty string if the plan is ran with 'ensure=absent'
  #
  apply($targets,  '_catch_errors' => true) {
    powerstore_volume { $volume_name: 
      protection_policy_id => $ensure ? { 'present' => $plan_pp_id, 'absent' => '' }
    }
  }


  # Just fetching the volume post apply() block to deliver a visual
  # confirmation that it worked
  #
  $plan_vol = Hash(
    get_resources($targets, "Powerstore_volume[${volume_name}]")[0]['resources'].map |$r| {
      [$r.keys, $r.values]
    }.flatten
  )

  return $plan_vol
}
