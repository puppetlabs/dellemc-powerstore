require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_policy',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    Use this resource type to manage protection policies and to view information about performance policies.

Note: Performance policies are predefined for high, low, and medium performance. They cannot be added to or changed.
  EOS
  attributes:   {
    ensure:      {
      type:      "Enum['present', 'absent']",
      desc:      "Whether this resource should be present or absent on the target system.",
      default:   "present",
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
      type:      "Optional[String]",
      desc:      "Unique identifier of the protection policy to be deleted.",
      behaviour: :read_only,
    },
    is_replica:          { 
      type:      "Optional[Boolean]",
      desc:      "Indicates whether this is a replica policy, which is applied to replication destination storage resources. A policy of this type is restricted from many operations.",
      default:   false,
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
    type:          { 
      type:      "Optional[Enum['Protection','Performance']]",
      desc:      "Supported policy types. * Protection - A protection policy, consisting of snapshot and replication rules. * Performance - A performance policy, consisting of performance rules.",
    },
    type_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to type",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
