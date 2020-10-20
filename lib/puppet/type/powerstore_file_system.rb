require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_file_system',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    Manage NAS file systems.
  EOS
  attributes:   {
    ensure:      {
      type:      "Enum['present', 'absent']",
      desc:      "Whether this resource should be present or absent on the target system.",
      default:   "present",
    },
    access_policy:          { 
      type:      "Optional[Enum['Native','UNIX','Windows']]",
      desc:      "File system security access policies. Each file system uses its access policy to determine how to reconcile the differences between NFS and SMB access control. Selecting an access policy determines which mechanism is used to enforce file security on the particular file system. * Native - Native Security. * UNIX - UNIX Security. * Windows - Windows Security.",
      default:   "Native",
    },
    access_policy_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to access_policy",
    },
    access_type:          { 
      type:      "Optional[Enum['Snapshot','Protocol']]",
      desc:      "Indicates whether the snapshot directory or protocol access is granted to the file system snapshot.* Snapshot- Snapshot access is via the .snapshot folder in the file system.* Protocol - Protocol access is via normal file shares. Protocol access is not provided by default - the NFS and/or SMB share must be created explicitly for the snapshot.",
      default:   "Snapshot",
    },
    access_type_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to access_type",
    },
    creation_timestamp:          { 
      type:      "Optional[String]",
      desc:      "Time, in seconds, when the snapshot was created.",
    },
    creator_type:          { 
      type:      "Optional[Enum['Scheduler','User']]",
      desc:      "Enumeration of possible snapshot creator types. * Scheduler - Created by a snapshot schedule.* User - Created by a user.* External_VSS - Created by Windows Volume Shadow Copy Service (VSS) to obtain an application consistent snapshot.* External_NDMP - Created by an NDMP backup operation.* External_Restore - Created as a backup snapshot before a snapshot restore.* External_Replication_Manager - Created by Replication Manager.* Snap_CLI - Created inband by SnapCLI.* AppSync - Created by AppSync.",
    },
    creator_type_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to creator_type",
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
    filesystem_type:          { 
      type:      "Optional[Enum['Primary','Snapshot']]",
      desc:      "* Primary - Normal file system or clone.* Snapshot - Snapshot of a file system.",
      default:   "Primary",
    },
    filesystem_type_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to filesystem_type",
    },
    folder_rename_policy:          { 
      type:      "Optional[Enum['All_Allowed','SMB_Forbidden','All_Forbidden']]",
      desc:      "File system folder rename policies for the file system with multiprotocol access enabled. These policies control whether the directory can be renamed from NFS or SMB clients when at least one file is opened in the directory, or in one of its child directories. * All_Allowed - All protocols are allowed to rename directories without any restrictions. * SMB_Forbidden - A directory rename from the SMB protocol will be denied if at least one file is opened in the directory or in one of its child directories. * All_Forbidden - Any directory rename request will be denied regardless of the protocol used, if at least one file is opened in the directory or in one of its child directories.",
      default:   "All_Forbidden",
    },
    folder_rename_policy_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to folder_rename_policy",
    },
    grace_period:          { 
      type:      "Optional[Integer[-1,2147483647]]",
      desc:      "Grace period of soft limits (seconds): -1: default: Infinite grace (Windows policy).  0: Use system default of 1 week. positive: Grace period after which the soft limit is treated as a hard limit (seconds).",
      default:   -1,
    },
    id:          { 
      type:      "String",
      desc:      "File system id.",
      behaviour: :read_only,
    },
    is_async_m_time_enabled:          { 
      type:      "Optional[Boolean]",
      desc:      "Indicates whether asynchronous MTIME is enabled on the file system or protocol snaps that are mounted writeable. Values are:* true - Asynchronous MTIME is enabled on the file system.* false - Asynchronous MTIME is disabled on the file system.",
      default:   false,
    },
    is_modified:          { 
      type:      "Optional[Boolean]",
      desc:      "Indicates whether the snapshot may have changed since it was created. Values are:true - Snapshot is or was shared with read/write access.false - Snapshot was never shared.        ",
    },
    is_quota_enabled:          { 
      type:      "Optional[Boolean]",
      desc:      "Indicates whether quota is enabled. Quotas are not supported for read-only file systems. Default value for the grace period is set to infinite=-1 to match Windows' quota policyValues are:* true - Start tracking usages for all users on a file system or a quota tree, and user quota limits will be enforced.* false - Stop tracking usages for all users on a file system or a quota tree, and user quota limits will not be enforced.",
    },
    is_smb_no_notify_enabled:          { 
      type:      "Optional[Boolean]",
      desc:      "Indicates whether notifications of changes to directory file structure are enabled.* true - Change directory notifications are enabled.* false - Change directory notifications are disabled.                      ",
      default:   false,
    },
    is_smb_notify_on_access_enabled:          { 
      type:      "Optional[Boolean]",
      desc:      "Indicates whether file access notifications are enabled on the file system. Values are:* true - File access notifications are enabled on the file system.* false - File access notifications are disabled on the file system.",
      default:   false,
    },
    is_smb_notify_on_write_enabled:          { 
      type:      "Optional[Boolean]",
      desc:      "Indicates whether file writes notifications are enabled on the file system. Values are:* true - File writes notifications are enabled on the file system.* false - File writes notifications are disabled on the file system.",
      default:   false,
    },
    is_smb_op_locks_enabled:          { 
      type:      "Optional[Boolean]",
      desc:      "Indicates whether opportunistic file locking is enabled on the file system. Values are:* true - Opportunistic file locking is enabled on the file system.* false - Opportunistic file locking is disabled on the file system.",
      default:   true,
    },
    is_smb_sync_writes_enabled:          { 
      type:      "Optional[Boolean]",
      desc:      "Indicates whether the synchronous writes option is enabled on the file system. Values are:* true - Synchronous writes option is enabled on the file system.* false - Synchronous writes option is disabled on the file system.",
      default:   false,
    },
    last_refresh_timestamp:          { 
      type:      "Optional[String]",
      desc:      "Time, in seconds, when the snapshot was last refreshed.",
    },
    last_writable_timestamp:          { 
      type:      "Optional[String]",
      desc:      "If not mounted, and was previously mounted, the time (in seconds) of last mount. If never mounted, the value will be zero.",
    },
    locking_policy:          { 
      type:      "Optional[Enum['Advisory','Mandatory']]",
      desc:      "File system locking policies. These policy choices control whether the NFSv4 range locks are honored. Because NFSv3 is advisory by design, this policy specifies that the NFSv4 locking feature behaves like NFSv3 (advisory mode), for backward compatiblity with applications expecting an advisory locking scheme.   * Advisory - No lock checking for NFS and honor SMB lock range only for SMB. * Mandatory - Honor SMB and NFS lock range.",
      default:   "Advisory",
    },
    locking_policy_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to locking_policy",
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
    parent_id:          { 
      type:      "Optional[String]",
      desc:      "The object id of the parent of this file system (only applies to clones and snapshots). If the parent of a clone has been deleted the object_id will contain null.",
    },
    protection_policy_id:          { 
      type:      "Optional[String]",
      desc:      "Id of the protection policy applied to the file system.",
    },
    size_total:          { 
      type:      "Integer[3221225472,281474976710656]",
      desc:      "Size that the file system presents to the host or end user. (Bytes)",
    },
    size_used:          { 
      type:      "Optional[Integer[0,9223372036854775807]]",
      desc:      "Size used, in bytes, for the data and metadata of the file system.",
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
