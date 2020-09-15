require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_replication_rule',
  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this apt key should be present or absent on the target system.'
    },

    alert_threshold:          {
      type:      'Optional[Integer]',
      desc:      "Acceptable delay in minutes between the expected and actual replication sync intervals. The system generates an alert if the delay between the expected and actual sync exceeds this threshold. Alert threshold has the default value of one RPO in minutes.",
      behaviour: :init_only,
    },
    body:          {
      type:      'Hash',
      desc:      "",
      behaviour: :parameter,
    },
    id:          {
      type:      'String',
      desc:      "Unique identifier of the replication rule.",
      behaviour: :parameter,
    },
    name:          {
      type:      'Optional[String]',
      desc:      "Name of the replication rule.",
      behaviour: :init_only,
    },
    remote_system_id:          {
      type:      'Optional[String]',
      desc:      "Unique identifier of the remote system to which this rule will replicate the associated resources.",
      behaviour: :init_only,
    },
    rpo:          {
      type:      'Optional[String]',
      desc:      "Recovery point objective (RPO), which is the acceptable amount of data, measured in units of time, that may be lost in case of a failure.",
      behaviour: :init_only,
    }, 
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt'
  },
)