require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_smb_share',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    description:          {
      type:      'Optional[String]',
      desc:      "NFS Share description.",
      behaviour: :init_only,
    },
    file_system_id:          {
      type:      'String',
      desc:      "Unique identifier of the file system on which the SMB Share will be created.",
      behaviour: :init_only,
    },
    id:          {
      type:      'String',
      desc:      "SMB Share object id.",
      behaviour: :init_only,
    },
    is_abe_enabled:          {
      type:      'Optional[Boolean]',
      desc:      "Indicates whether Access-based Enumeration (ABE) is enabled. ABE filters the list of available files and folders on a server to include only those, that the requesting user has access to. Values are:- true - ABE is enabled.- false - ABE is disabled.",
      behaviour: :init_only,
    },
    is_branch_cache_enabled:          {
      type:      'Optional[Boolean]',
      desc:      "Indicates whether BranchCace optimization is enabled. BranchCache optimization technology copies content from your main office or hosted cloud content servers and caches the content at branch office locations, allowing client computers at branch offices to access the content locally rather than over the WAN. Values are:- true - BranchCache is enabled.- false - BranchCache is disabled.",
      behaviour: :init_only,
    },
    is_continuous_availability_enabled:          {
      type:      'Optional[Boolean]',
      desc:      "Indicates whether continuous availability for Server Message Block (SMB) 3.0 is enabled for the SMB Share. Values are:- true - Continuous availability for SMB 3.0 is enabled for the SMB Share.- false - Continuous availability for SMB 3.0 is disabled for the SMB Share.",
      behaviour: :init_only,
    },
    is_encryption_enabled:          {
      type:      'Optional[Boolean]',
      desc:      "Indicates whether encryption for Server Message Block (SMB) 3.0 is enabled at the shared folder level. Values are:- true - encryption for SMB 3.0 is enabled.- false - encryption for SMB 3.0 is disabled.",
      behaviour: :init_only,
    },
    name:          {
      type:      'String',
      desc:      "SMB share name.",
      behaviour: :namevar,
    },
    offline_availability:          {
      type:      'Optional[String]',
      desc:      "Defines valid states of Offline Availability,   * Manual - Only specified files will be available offline.   * Documents - All files that users open will be available offline.   * Programs - Program will preferably run from the offline cache even when connected to the network. All files that users open will be available offline.   * None - Prevents clients from storing documents and programs in offline cache (default).",
      behaviour: :init_only,
    },
    path:          {
      type:      'String',
      desc:      "Local path to the file system or any existing sub-folder of the file system that is shared over the network.This path is relative to the NAS Server and must start with the filesystem's mountpoint path, which is the filesystem name.For example to share the top-level of a filesystem named svr1fs1, which is on the /svr1fs1 mountpoint of the NAS Server, use /svr1fs1 in the path parameter.SMB shares allow you to create multiple network shares for the same local path.",
      behaviour: :init_only,
    },
    umask:          {
      type:      'Optional[String]',
      desc:      "The default UNIX umask for new files created on the Share.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
