require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_import_host_system',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    Use these resource types to manage import host systems. Import host enables communication with multipathing software on the host system to perform import operations. While configuring the import_host_system if the host is not present a new Host will be created. If Host is already present, the same Host will be updated with the import_host_system details. Also, import_host_system supports FC and ISCSI connections between Host and source arrays. So for a single import_host_system which supports both FC and ISCSI; there would be two Hosts entries for representing the FC and iSCSI connections.
  EOS
  attributes:   {
    ensure:      {
      type:      "Enum['present', 'absent']",
      desc:      "Whether this resource should be present or absent on the target system.",
      default:   "present",
    },
    agent_address:          { 
      type:      "Optional[String]",
      desc:      "Hostname or IPv4 address of the import host system.",
      behaviour: :init_only,
    },
    agent_api_version:          { 
      type:      "Optional[String]",
      desc:      "API version of the import host system.",
    },
    agent_port:          { 
      type:      "Optional[Integer[0,65535]]",
      desc:      "TCP port of the import host system.",
      behaviour: :init_only,
    },
    agent_status:          { 
      type:      "Optional[Enum['Unknown','Running','Conflict_Detected','Version_Unsupported']]",
      desc:      "Status of the import host system. Valid values are: * Unknown - Agent status is unknown. * Running - Agent is up and running. * Conflict_Detected - Agent detected that there are multiple MPIOs installed on the host and Destination Powerstore MPIO is not able to claim destination device as some other MPIO has already claimed it. * Version_Unsupported - Agent detected that the OS or any other dependent component does not satisfy the version as expected by the it.",
    },
    agent_status_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to agent_status",
    },
    agent_type:          { 
      type:      "Optional[Enum['EQL','Native_MPIO','Power_Path','Unknown']]",
      desc:      "Type of import host system. Valid values are: * EQL - EQL MPIO.  * Native_MPIO - Native MPIO.  * Power_Path - POWER PATH MPIO.  * Unknown - Type of host agent is unknown to PowerStore.",
    },
    agent_type_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to agent_type",
    },
    agent_version:          { 
      type:      "Optional[String]",
      desc:      "Version of the import host system.",
    },
    chap_mutual_password:          { 
      type:      "Optional[String]",
      desc:      "Password for mutual CHAP authentication. This password is required when the cluster is using mutual authentication CHAP mode.",
      behaviour: :init_only,
    },
    chap_mutual_username:          { 
      type:      "Optional[String]",
      desc:      "Username for mutual CHAP authentication. This username is required when the cluster is using mutual authentication CHAP mode.",
      behaviour: :init_only,
    },
    chap_single_password:          { 
      type:      "Optional[String]",
      desc:      "Password for single CHAP authentication. This password is required when the cluster is using single authentication CHAP mode.",
      behaviour: :init_only,
    },
    chap_single_username:          { 
      type:      "Optional[String]",
      desc:      "Username for single CHAP authentication. This username is required when the cluster is using single authentication CHAP mode.",
      behaviour: :init_only,
    },
    id:          { 
      type:      "String",
      desc:      "Unique identifier of the import host system",
      behaviour: :namevar,
    },
    last_update_time:          { 
      type:      "Optional[String]",
      desc:      "Time when the import host system was last updated.",
    },
    os_type:          { 
      type:      "Optional[Enum['Windows','Linux','ESXi','Unknown']]",
      desc:      "Operating system of the import host system. Valid values are: * Windows - Windows.  * Linux - Linux.  * ESXi - ESXi.  * Unknown - Operating system of the host system is unknown to PowerStore.",
      behaviour: :init_only,
    },
    os_type_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to os_type",
    },
    os_version:          { 
      type:      "Optional[String]",
      desc:      "Operating system version of the import host system.",
    },
    password:          { 
      type:      "Optional[String]",
      desc:      "Password for the specified username.",
      behaviour: :init_only,
    },
    user_name:          { 
      type:      "Optional[String]",
      desc:      "Username for the import host system.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
