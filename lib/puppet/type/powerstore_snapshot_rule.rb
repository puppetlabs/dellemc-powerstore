require 'puppet/resource_api'

# rubocop:disable Style/StringLiterals
Puppet::ResourceApi.register_type(
  name: 'powerstore_snapshot_rule',
  features: ['remote_resource'],
  # rubocop:disable Lint/UnneededDisable
  # rubocop:disable Layout/TrailingWhitespace
  desc: <<-EOS,
    Use this resource type to manage snapshot rules that are used in protection policies.
  EOS
  attributes:   {
    ensure:      {
      type:      "Enum['present', 'absent']",
      desc:      'Whether this resource should be present or absent on the target system.',
      default:   'present',
    },
    days_of_week:          {
      type:      "Optional[Array[Enum['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday']]]",
      desc:      "Days of the week when the rule should be applied. Applies only for rules where the time_of_day parameter is set.",
    },
    days_of_week_l10n:          {
      type:      "Optional[Array[String]]",
      desc:      "Localized message array corresponding to days_of_week",
    },
    delete_snaps:          {
      type:      "Optional[Boolean]",
      desc:      "Specify whether all snapshots previously created by this rule should also be deleted when this rule is removed.",
      behaviour: :parameter,
    },
    desired_retention:          {
      type:      "Optional[Integer[1,8760]]",
      desc:      "Desired snapshot retention period in hours. The system will retain snapshots for this time period, if space is available.",
    },
    id:          {
      type:      "Optional[String]",
      desc:      "Unique identifier of the snapshot rule.",
      behaviour: :read_only,
    },
    interval:          {
      type:      "Optional[Enum['Five_Minutes','Fifteen_Minutes','Thirty_Minutes','One_Hour','Two_Hours','Three_Hours','Four_Hours','Six_Hours','Eight_Hours','Twelve_Hours','One_Day']]",
      desc:      "Interval between snapshots. Either the interval parameter or the time_of_day parameter may be set. Setting one clears the other parameter.",
    },
    interval_l10n:          {
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to interval",
    },
    is_replica:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates if this is a replica of a rule or policy on a remote system that is the source of a replication session replicating a resource to the local system.",
    },
    name:          {
      type:      "String",
      desc:      "Snapshot rule name.",
      behaviour: :namevar,
    },
    time_of_day:          {
      type:      "Optional[String]",
      desc:      "Time of the day to take a daily snapshot, with format 'hh:mm' in 24 hour time format. Either the interval parameter or the time_of_day parameter may be set, but not both.",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
