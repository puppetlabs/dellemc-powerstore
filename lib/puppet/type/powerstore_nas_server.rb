require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_nas_server',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    backup_i_pv4_interface_id:          {
      type:      'Optional[String]',
      desc:      "Unique identifier of the preferred IPv4 backup interface.",
      behaviour: :init_only,
    },
    backup_i_pv6_interface_id:          {
      type:      'Optional[String]',
      desc:      "Unique identifier of the preferred IPv6 backup interface.",
      behaviour: :init_only,
    },
    current_node_id:          {
      type:      'Optional[String]',
      desc:      "Unique identifier of the node on which the NAS server is running.",
      behaviour: :init_only,
    },
    current_unix_directory_service:          {
      type:      'Optional[String]',
      desc:      "Define the Unix directory service used for looking up identity information for Unix such as UIDs, GIDs, net groups, and so on.",
      behaviour: :init_only,
    },
    default_unix_user:          {
      type:      'Optional[String]',
      desc:      "Default Unix user name used for granting access in case of Windows to Unix user mapping failure. When empty, access in such case is denied.",
      behaviour: :init_only,
    },
    default_windows_user:          {
      type:      'Optional[String]',
      desc:      "Default Windows user name used for granting access in case of Unix to Windows user mapping failure. When empty, access in such case is denied.",
      behaviour: :init_only,
    },
    description:          {
      type:      'Optional[String]',
      desc:      "Description of the NAS server.",
      behaviour: :init_only,
    },
    id:          {
      type:      'String',
      desc:      "Unique identifier of the NAS server.",
      behaviour: :init_only,
    },
    is_auto_user_mapping_enabled:          {
      type:      'Optional[Boolean]',
      desc:      "A Windows user must have a corresponding matching Unix user (uid) in order to connect.This attribute enables you to automatically generate this Unix user (uid), if that Windows user does not have any in the configured Unix directory service (UDS).In a pure SMB or non multi-protocol environment, this should be set to true.",
      behaviour: :init_only,
    },
    is_username_translation_enabled:          {
      type:      'Optional[Boolean]',
      desc:      "Enable the possibility to match a windows account to a Unix account with different names",
      behaviour: :init_only,
    },
    name:          {
      type:      'Optional[String]',
      desc:      "Name of the NAS server.",
      behaviour: :namevar,
    },
    preferred_node_id:          {
      type:      'Optional[String]',
      desc:      "Unique identifier of the preferred node for the NAS server The initial value (on NAS server create) is taken from the current node.",
      behaviour: :init_only,
    },
    production_i_pv4_interface_id:          {
      type:      'Optional[String]',
      desc:      "Unique identifier of the preferred IPv4 production interface.",
      behaviour: :init_only,
    },
    production_i_pv6_interface_id:          {
      type:      'Optional[String]',
      desc:      "Unique identifier of the preferred IPv6 production interface.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
