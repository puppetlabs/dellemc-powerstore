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
      type:      "Optional[Optional[String]]",
      desc:      "Description of the tree quota.",
      behaviour: :init_only,
    },
    file_system_id:          {
      type:      "String",
      desc:      "Unique identifier of the associated file system.",
      behaviour: :init_only,
    },
    hard_limit:          {
      type:      "Optional[Optional[Integer[0,9223372036854775807]]]",
      desc:      "Hard limit of the tree quota, in bytes. No hard limit when set to 0. This value can be used to compute amount of space that is consumed without limiting the space. Value is always rounded up to match the physical block size of the filesystem.",
      behaviour: :init_only,
    },
    id:          {
      type:      "String",
      desc:      "Unique identifier of the tree quota.",
      behaviour: :namevar,
    },
    is_user_quotas_enforced:          {
      type:      "Optional[Optional[Boolean]]",
      desc:      "Whether the quota must be enabled for all users, and whether user quota limits, if any, are enforced.Values are:- true - start tracking usage for all users on the quota tree, and enforce user quota limits.- false - stop tracking usage for all users on the quota tree, and do not enforce user quota limits.",
      behaviour: :init_only,
    },
    path:          {
      type:      "String",
      desc:      "Path relative to the root of the associated filesystem.",
      behaviour: :init_only,
    },
    remaining_grace_period:          {
      type:      "Optional[Optional[Integer[0,9223372036854775807]]]",
      desc:      "Remaining grace period, in seconds, after the soft limit is exceeded:- 0 - Grace period has already expired- -1 - No grace period in-progress, or infinite grace period setThe grace period of user quotas is set in the file system quota config.",
    },
    size_used:          {
      type:      "Optional[Optional[Integer[0,9223372036854775807]]]",
      desc:      "Size already used on the tree quota, in bytes.",
    },
    soft_limit:          {
      type:      "Optional[Optional[Integer[0,9223372036854775807]]]",
      desc:      "Soft limit of the tree quota, in bytes. No hard limit when set to 0. Value is always rounded up to match the physical block size of the filesystem.",
      behaviour: :init_only,
    },
    state:          {
      type:      "Optional[Optional[Enum['Ok','Soft_Exceeded','Soft_Exceeded_And_Expired','Hard_Reached']]]",
      desc:      "State of the user quota or tree quota record period.* OK - No quota limits are exceeded.* Soft_Exceeded - Soft limit is exceeded, and grace period is not expired.* Soft_Exceeded_And_Expired - Soft limit is exceeded, and grace period is expired.* Hard_Reached - Hard limit is reached.",
    },
    state_l10n:          {
      type:      "Optional[Optional[String]]",
      desc:      "Localized message string corresponding to state",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
