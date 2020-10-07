require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_file_system',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: "Enum['present', 'absent']",
      desc: "Whether this resource should be present or absent on the target system.",
      default: "present",
    },

    access_policy:          {
      type:      "Optional[Enum['Native','UNIX','Windows']]",
      desc:      "File system security access policies. Each file system uses its access policy to determine how to reconcile the differences between NFS and SMB access control. Selecting an access policy determines which mechanism is used to enforce file security on the particular file system. * Native - Native Security. * UNIX - UNIX Security. * Windows - Windows Security.",
    },
    default_hard_limit:          {
      type:      "Optional[Integer[0,9223372036854775807]]",
      desc:      "Default hard limit of user quotas and tree quotas (bytes). The hard limit value is always rounded up to match the file system's physical block size.(0 means 'No limitation'. This value can be used to compute the amount of space consumed without limiting the space).",
    },
    default_soft_limit:          {
      type:      "Optional[Integer[0,9223372036854775807]]",
      desc:      "Default soft limit of user quotas and tree quotas (bytes). Value is always rounded up to match the file system's physical block size.(0 means 'No limitation'.)",
    },
    description:          {
      type:      "Optional[String[0,255]]",
      desc:      "File system description. (255 UTF-8 characters).",
    },
    expiration_timestamp:          {
      type:      "Optional[String]",
      desc:      "Time when the snapshot will expire. Use 1970-01-01T00:00:00.000Z to set expiration timestamp to null.",
    },
    folder_rename_policy:          {
      type:      "Optional[Enum['All_Allowed','SMB_Forbidden','All_Forbidden']]",
      desc:      "File system folder rename policies for the file system with multiprotocol access enabled. These policies control whether the directory can be renamed from NFS or SMB clients when at least one file is opened in the directory, or in one of its child directories. * All_Allowed - All protocols are allowed to rename directories without any restrictions. * SMB_Forbidden - A directory rename from the SMB protocol will be denied if at least one file is opened in the directory or in one of its child directories. * All_Forbidden - Any directory rename request will be denied regardless of the protocol used, if at least one file is opened in the directory or in one of its child directories.",
    },
    grace_period:          {
      type:      "Optional[Integer[-1,2147483647]]",
      desc:      "Grace period of soft limits (seconds): -1: default: Infinite grace (Windows policy).  0: Use system default of 1 week. positive: Grace period after which the soft limit is treated as a hard limit (seconds).",
    },
    id:          {
      type:      "String",
      desc:      "File system id.",
    },
    is_async_m_time_enabled:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether asynchronous MTIME is enabled on the file system or protocol snaps that are mounted writeable. Values are:* true - Asynchronous MTIME is enabled on the file system.* false - Asynchronous MTIME is disabled on the file system.",
    },
    is_quota_enabled:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether quota is enabled. Quotas are not supported for read-only file systems. Default value for the grace period is set to infinite=-1 to match Windows' quota policyValues are:* true - Start tracking usages for all users on a file system or a quota tree, and user quota limits will be enforced.* false - Stop tracking usages for all users on a file system or a quota tree, and user quota limits will not be enforced.",
    },
    is_smb_no_notify_enabled:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether notifications of changes to directory file structure are enabled.* true - Change directory notifications are enabled.* false - Change directory notifications are disabled.                      ",
    },
    is_smb_notify_on_access_enabled:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether file access notifications are enabled on the file system. Values are:* true - File access notifications are enabled on the file system.* false - File access notifications are disabled on the file system.",
    },
    is_smb_notify_on_write_enabled:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether file writes notifications are enabled on the file system. Values are:* true - File writes notifications are enabled on the file system.* false - File writes notifications are disabled on the file system.",
    },
    is_smb_op_locks_enabled:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether opportunistic file locking is enabled on the file system. Values are:* true - Opportunistic file locking is enabled on the file system.* false - Opportunistic file locking is disabled on the file system.",
    },
    is_smb_sync_writes_enabled:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether the synchronous writes option is enabled on the file system. Values are:* true - Synchronous writes option is enabled on the file system.* false - Synchronous writes option is disabled on the file system.",
    },
    locking_policy:          {
      type:      "Optional[Enum['Advisory','Mandatory']]",
      desc:      "File system locking policies. These policy choices control whether the NFSv4 range locks are honored. Because NFSv3 is advisory by design, this policy specifies that the NFSv4 locking feature behaves like NFSv3 (advisory mode), for backward compatiblity with applications expecting an advisory locking scheme.   * Advisory - No lock checking for NFS and honor SMB lock range only for SMB. * Mandatory - Honor SMB and NFS lock range.",
    },
    name:          {
      type:      "String[1,255]",
      desc:      "Name of the file system. (255 UTF-8 characters).",
      behaviour: :namevar,
    },
    nas_server_id:          {
      type:      "String",
      desc:      "Id of the NAS Server on which the file system is mounted.",
      behaviour: :init_only,
    },
    protection_policy_id:          {
      type:      "Optional[String]",
      desc:      "Id of the protection policy applied to the file system.",
    },
    size_total:          {
      type:      "Integer[3221225472,281474976710656]",
      desc:      "Size that the file system presents to the host or end user. (Bytes)",
    },
    smb_notify_on_change_dir_depth:          {
      type:      "Optional[Integer[1,512]]",
      desc:      "Lowest directory level to which the enabled notifications apply, if any.",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
