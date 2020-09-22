require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_snapshot_rule',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    days_of_week:          {
      type:      'Optional[Array]',
      desc:      "Days of the week when the rule should be applied. Applies only for rules where the time_of_day parameter is set.",
      behaviour: :init_only,
    },
    desired_retention:          {
      type:      'Optional[Integer]',
      desc:      "Desired snapshot retention period in hours. The system will retain snapshots for this time period, if space is available.",
      behaviour: :init_only,
    },
    id:          {
      type:      'String',
      desc:      "Unique identifier of the snapshot rule.",
      behaviour: :init_only,
    },
    interval:          {
      type:      'Optional[String]',
      desc:      "Interval between snapshots. Either the interval parameter or the time_of_day parameter may be set. Setting one clears the other parameter.",
      behaviour: :init_only,
    },
    name:          {
      type:      'Optional[String]',
      desc:      "Snapshot rule name.",
      behaviour: :namevar,
    },
    time_of_day:          {
      type:      'Optional[String]',
      desc:      "Time of the day to take a daily snapshot, with format 'hh:mm' in 24 hour time format. Either the interval parameter or the time_of_day parameter may be set, but not both.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
