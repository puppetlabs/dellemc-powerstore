require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_policy',
  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this apt key should be present or absent on the target system.'
    },

    add_replication_rule_ids:          {
      type:      'Optional[Array]',
      desc:      "Replication rule identifiers to be added to this policy.",
      behaviour: :init_only,
    },
    add_snapshot_rule_ids:          {
      type:      'Optional[Array]',
      desc:      "Snapshot rule identifiers to be added to this policy.",
      behaviour: :init_only,
    },
    body:          {
      type:      'Hash',
      desc:      "",
      behaviour: :parameter,
    },
    description:          {
      type:      'Optional[String]',
      desc:      "Policy description.",
      behaviour: :init_only,
    },
    id:          {
      type:      'String',
      desc:      "Unique identifier of the protection policy to be deleted.",
      behaviour: :parameter,
    },
    name:          {
      type:      'Optional[String]',
      desc:      "Policy name.",
      behaviour: :init_only,
    },
    remove_replication_rule_ids:          {
      type:      'Optional[Array]',
      desc:      "Replication rule identifiers to be removed from this policy.",
      behaviour: :init_only,
    },
    remove_snapshot_rule_ids:          {
      type:      'Optional[Array]',
      desc:      "Snapshot rule identifiers to be removed from this policy.",
      behaviour: :init_only,
    },
    replication_rule_ids:          {
      type:      'Optional[Array]',
      desc:      "Replication rule identifiers that should replace the current list of replication rule identifiers in this policy.",
      behaviour: :init_only,
    },
    snapshot_rule_ids:          {
      type:      'Optional[Array]',
      desc:      "Snapshot rule identifiers that should replace the current list of snapshot rule identifiers in this policy.",
      behaviour: :init_only,
    }, 
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt'
  },
)