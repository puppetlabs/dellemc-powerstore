require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_policy',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: "Enum['present', 'absent']",
      desc: "Whether this resource should be present or absent on the target system.",
      default: "present",
    },

    add_replication_rule_ids:          {
      type:      "Optional[Array[String]]",
      desc:      "Replication rule identifiers to be added to this policy.",
    },
    add_snapshot_rule_ids:          {
      type:      "Optional[Array[String]]",
      desc:      "Snapshot rule identifiers to be added to this policy.",
    },
    description:          {
      type:      "Optional[String]",
      desc:      "Policy description.",
    },
    id:          {
      type:      "String",
      desc:      "Unique identifier of the policy to be modified.",
    },
    name:          {
      type:      "String",
      desc:      "Policy name.",
      behaviour: :namevar,
    },
    remove_replication_rule_ids:          {
      type:      "Optional[Array[String]]",
      desc:      "Replication rule identifiers to be removed from this policy.",
    },
    remove_snapshot_rule_ids:          {
      type:      "Optional[Array[String]]",
      desc:      "Snapshot rule identifiers to be removed from this policy.",
    },
    replication_rule_ids:          {
      type:      "Optional[Array[String]]",
      desc:      "Replication rule identifiers included in this policy. At least one snapshot rule or one replication rule must be specified to create a protection policy.",
    },
    snapshot_rule_ids:          {
      type:      "Optional[Array[String]]",
      desc:      "Snapshot rule identifiers included in this policy. At least one snapshot rule or one replication rule must be specified to create a protection policy.",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
