require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_nfs_server',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    credentials_cache_ttl:          {
      type:      'Optional[Integer]',
      desc:      "Sets the Time-To-Live (in minutes) expiration stamp for a Windows entry in the credentials cache. When failed mapping entries expire, the system retries mapping the UID to the SID.",
      behaviour: :init_only,
    },
    host_name:          {
      type:      'Optional[String]',
      desc:      "The name that will be used by NFS clients to connect to this NFS server. This name is required when using secure NFS, except when is_use_smb_config_enabled is true. In this case host_name is forced to the SMB server computer name, and must not be specified.",
      behaviour: :init_only,
    },
    id:          {
      type:      'String',
      desc:      "Unique identifier of the NFS server.",
      behaviour: :namevar,
    },
    is_extended_credentials_enabled:          {
      type:      'Optional[Boolean]',
      desc:      "Indicates whether the NFS server supports more than 16 Unix groups in a Unix credential. Valid values are,- true - NFS server supports more than 16 Unix groups in a Unix credential. The NFS server will send additional request to Unix Directory service to identify Unix groups.- false - NFS server supports more than 16 Unix groups in a Unix credential. The NFS server will send additional request to Unix Directory service to identify Unix groups. Note - The NFS server builds its own Unix credential when it supports more than 16 groups. This process can slow performance.",
      behaviour: :init_only,
    },
    is_nfsv3_enabled:          {
      type:      'Optional[Boolean]',
      desc:      "Indicates whether NFSv3 is enabled on the NAS server. When enabled, NFS shares can be accessed with NFSv3. When disabled, NFS shares cannot be accessed with NFSv3 protocol.- true - NFSv3 is enabled on the specified NAS server.- false - NFSv3 is disabled on the specified NAS server.",
      behaviour: :init_only,
    },
    is_nfsv4_enabled:          {
      type:      'Optional[Boolean]',
      desc:      "Indicates whether NFSv4 is enabled on the NAS server. When enabled, NFS shares can be accessed with NFSv4. When disabled, NFS shares cannot be accessed with NFSv4 protocol.- true - NFSv4 is enabled on the specified NAS server.- false - NFSv4 is disabled on the specified NAS server.",
      behaviour: :init_only,
    },
    is_secure_enabled:          {
      type:      'Optional[Boolean]',
      desc:      "Indicates whether secure NFS is enabled on the NFS server.- true - Secure NFS is Enabled.- false - Secure NFS is disabled.",
      behaviour: :init_only,
    },
    is_skip_unjoin:          {
      type:      'Optional[Boolean]',
      desc:      "Allow to bypass NFS server unjoin. If false modification will fail if secure is enabled and current kdc_type is MS Windows. If secure is enabled either unjoin NFS server before deleting or set value to true.",
      behaviour: :init_only,
    },
    is_use_smb_config_enabled:          {
      type:      'Optional[Boolean]',
      desc:      "Indicates whether SMB authentication is used to authenticate to the KDC. Values are:- true: Indicates that the the configured SMB Server settings are used for Kerberos authentication.- false: Indicates that Kerberos uses its own settings.",
      behaviour: :init_only,
    },
    nas_server_id:          {
      type:      'String',
      desc:      "Unique identifier of the NAS server.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
