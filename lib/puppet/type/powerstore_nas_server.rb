require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_nas_server',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: "Enum['present', 'absent']",
      desc: "Whether this resource should be present or absent on the target system.",
      default: "present",
    },

    backup_i_pv4_interface_id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of the preferred IPv4 backup interface.",
    },
    backup_i_pv6_interface_id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of the preferred IPv6 backup interface.",
    },
    current_node_id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of the node on which the NAS server is running.",
    },
    current_preferred_i_pv4_interface_id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of the current active preferred IPv4 interface.",
    },
    current_preferred_i_pv6_interface_id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of the current active preferred IPv6 interface.",
    },
    current_unix_directory_service:          { 
      type:      "Optional[Enum['None','NIS','LDAP','Local_Files','Local_Then_NIS','Local_Then_LDAP']]",
      desc:      "Define the Unix directory service used for looking up identity information for Unix such as UIDs, GIDs, net groups, and so on.",
      behaviour: :init_only,
    },
    current_unix_directory_service_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to current_unix_directory_service",
    },
    default_unix_user:          { 
      type:      "Optional[String[0,63]]",
      desc:      "Default Unix user name used for granting access in case of Windows to Unix user mapping failure. When empty, access in such case is denied.",
      behaviour: :init_only,
    },
    default_windows_user:          { 
      type:      "Optional[String[0,1023]]",
      desc:      "Default Windows user name used for granting access in case of Unix to Windows user mapping failure. When empty, access in such case is denied.",
      behaviour: :init_only,
    },
    description:          { 
      type:      "Optional[String[0,255]]",
      desc:      "Description of the NAS server.",
      behaviour: :init_only,
    },
    domain_password:          { 
      type:      "Optional[String]",
      desc:      "Administrator password used to unjoin the associated SMB servers from the Active Directory (AD) domain before deleting the NAS server. This parameter is required when the skipDomainUnjoin parameter is false or not set, and the NAS server has SMB servers joined to an AD domain.",
    },
    domain_user_name:          { 
      type:      "Optional[String]",
      desc:      "Administrator login used to unjoin the associated SMB servers from the Active Directory (AD) domain before deleting the NAS server. This parameter is required when the skipDomainUnjoin parameter is false or not set, and the NAS server has SMB servers joined to an AD domain.",
    },
    id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of the NAS server.",
    },
    is_auto_user_mapping_enabled:          { 
      type:      "Optional[Boolean]",
      desc:      "A Windows user must have a corresponding matching Unix user (uid) in order to connect.This attribute enables you to automatically generates this Unix user (uid), if that Windows user does not have any in the configured Unix directory service (UDS).In a pure SMB or non multi-protocol environment, this should be set to true.",
      behaviour: :init_only,
    },
    is_skip_domain_unjoin:          { 
      type:      "Optional[Boolean]",
      desc:      "Indicates whether to keep the associated SMB servers joined to the Active Directory when the NAS server is deleted. Values are:\n - true - Keep the associated SMB servers joined to the Active Directory when the NAS server is deleted. - false - (Default) Try to unjoin the associated SMB servers from the Active Directory before deleting the NAS server.",
    },
    is_username_translation_enabled:          { 
      type:      "Optional[Boolean]",
      desc:      "Enable the possibility to match a Windows account with an Unix account with different names.",
      behaviour: :init_only,
    },
    name:          { 
      type:      "String[1,255]",
      desc:      "Name of the NAS server.",
      behaviour: :namevar,
    },
    operational_status:          { 
      type:      "Optional[Enum['Stopped','Starting','Started','Stopping','Failover','Degraded','Unknown']]",
      desc:      "NAS server operational status:* Stopped - NAS server is stopped.* Starting - NAS server is starting.* Started - NAS server is started.* Stopping - NAS server is stopping.* Failover - NAS server has failed over.* Degraded - NAS server is degraded (running without backup).* Unknown - NAS server state is unknown.",
    },
    operational_status_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to operational_status",
    },
    preferred_node_id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of the preferred node for the NAS server The initial value (on NAS server create) is taken from the current node.",
    },
    production_i_pv4_interface_id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of the preferred IPv4 production interface.",
    },
    production_i_pv6_interface_id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of the preferred IPv6 production interface.",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
