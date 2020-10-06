require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_file_tree_quota',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: "Enum['present', 'absent']",
      desc: "Whether this resource should be present or absent on the target system.",
      default: "present",
    },

    description:          {
      type:      "Optional[String]",
      desc:      "Description of the tree quota.",
    },
    file_system_id:          {
      type:      "String",
      desc:      "Unique identifier of the associated file system.",
      behaviour: :init_only,
    },
    hard_limit:          {
      type:      "Optional[Integer[0, 9223372036854775808]]",
      desc:      "Hard limit of the tree quota, in bytes. No hard limit when set to 0. This value can be used to compute amount of space that is consumed without limiting the space. Value is always rounded up to match the physical block size of the filesystem.",
    },
    id:          {
      type:      "String",
      desc:      "Unique identifier of the tree quota.",
      behaviour: :namevar,
    },
    is_user_quotas_enforced:          {
      type:      "Optional[Boolean]",
      desc:      "Whether the quota must be enabled for all users, and whether user quota limits, if any, are enforced.Values are:- true - start tracking usage for all users on the quota tree, and enforce user quota limits.- false - stop tracking usage for all users on the quota tree, and do not enforce user quota limits.",
    },
    path:          {
      type:      "String",
      desc:      "Path relative to the root of the associated filesystem.",
      behaviour: :init_only,
    },
    soft_limit:          {
      type:      "Optional[Integer[0, 9223372036854775808]]",
      desc:      "Soft limit of the tree quota, in bytes. No hard limit when set to 0. Value is always rounded up to match the physical block size of the filesystem.",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
