require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_replication_rule',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: "Enum['present', 'absent']",
      desc: "Whether this resource should be present or absent on the target system.",
      default: "present",
    },

    alert_threshold:          {
      type:      "Optional[Integer[0,1440]]",
      desc:      "Acceptable delay in minutes between the expected and actual replication sync intervals. The system generates an alert if the delay between the expected and actual sync exceeds this threshold. Alert threshold has the default value of one RPO in minutes.",
    },
    id:          {
      type:      "String",
      desc:      "Unique identifier of the replication rule.",
    },
    name:          {
      type:      "String",
      desc:      "Name of the replication rule.",
      behaviour: :namevar,
    },
    remote_system_id:          {
      type:      "String",
      desc:      "Unique identifier of the remote system to which this rule will replicate the associated resources.",
    },
    rpo:          {
      type:      "Enum['Five_Minutes','Fifteen_Minutes','Thirty_Minutes','One_Hour','Six_Hours','Twelve_Hours','One_Day']",
      desc:      "Recovery point objective (RPO), which is the acceptable amount of data, measured in units of time, that may be lost in case of a failure.",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
