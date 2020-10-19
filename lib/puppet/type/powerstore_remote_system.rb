require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_remote_system',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: "Enum['present', 'absent']",
      desc: "Whether this resource should be present or absent on the target system.",
      default: "present",
    },

    data_connection_state:          { 
      type:      "Optional[Enum['OK','Partial_Data_Connection_Loss','Complete_Data_Connection_Loss','Status_Not_Available','No_Targets_Discovered','Initializing']]",
      desc:      "Possible data connection states of a remote system:* OK                             - Normal conditions.* Partial_Data_Connection_Loss   - Partial data connection loss.* Complete_Data_Connection_Loss  - Complete data connection loss.* Status_Not_Available           - Status not available.* No_Targets_Discovered          - No targets discovered.* Initializing                   - Initializing",
    },
    data_connection_state_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to data_connection_state",
    },
    data_connections:          { 
      type:      "Optional[Array[Struct[{Optional[initiator_address] => String, Optional[node_id] => String, Optional[status] => Enum['Login_Success','Authentication_Failure','Connection_Refused','Login_Timeout','Network_Error','General_Failure','Login_Success_No_Ports','Discovery_Success','Discovery_Authentication_Failure','Discovery_Connection_Refused','Discovery_Timeout'], Optional[status_l10n] => String, Optional[target_address] => String, }]]]",
      desc:      "List of data connections from each appliance in the local cluster to iSCSI target IP address. Filtering on the fields of this embedded resource is not supported.",
    },
    data_network_latency:          { 
      type:      "Optional[Enum['Low','High']]",
      desc:      "Network latency choices for a remote system. Replication traffic can be tuned for higher efficiency depending on the expected network latency. This will only be used when the remote system type is PowerStore.* Low                      - Less than 5 milliseconds.* High                     - More than 5 milliseconds.",
    },
    data_network_latency_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to data_network_latency",
    },
    description:          { 
      type:      "Optional[String[1,256]]",
      desc:      "User-specified description of the remote system.",
    },
    discovery_chap_mode:          { 
      type:      "Optional[Enum['Disabled','Single','Mutual']]",
      desc:      "Challenge Handshake Authentication Protocol (CHAP) status:* Disabled     * Single       - Enabled for initiator authentication.* Mutual       - Enabled for initiator and target authentication.",
      behaviour: :init_only,
    },
    discovery_chap_mode_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to discovery_chap_mode",
    },
    id:          { 
      type:      "String",
      desc:      "Unique identifier of the remote system.
",
    },
    import_chap_info:          { 
      type:      "Optional[Struct[{Optional[initiator_discovery_password] => String, Optional[initiator_discovery_username] => String, Optional[initiator_session_password] => String, Optional[initiator_session_username] => String, Optional[target_discovery_password] => String, Optional[target_discovery_username] => String, Optional[target_session_password] => String, Optional[target_session_username] => String, }]]",
      desc:      "Information about the initiator, target session, or discovery CHAP secrets.",
      behaviour: :init_only,
    },
    iscsi_addresses:          { 
      type:      "Optional[Array[String]]",
      desc:      "iSCSI target IP addresses for the data connection to the remote system. Must be specified when creating a non-PowerStore remote system.",
      behaviour: :init_only,
    },
    management_address:          { 
      type:      "String",
      desc:      "Management IP address of the remote system instance. Only IPv4 is supported for non-PowerStore remote systems.Both IPv4 and IPv6 are supported for PowerStore remote systems.",
    },
    name:          { 
      type:      "Optional[String[1,128]]",
      desc:      "User-specified name of the remote system. Used only for non-PowerStore systems. This value must contain 128 or fewer printable Unicode characters.",
      behaviour: :namevar,
    },
    remote_password:          { 
      type:      "Optional[String]",
      desc:      "Password used to access the remote system. Used only for non-PowerStore systems.",
    },
    remote_username:          { 
      type:      "Optional[String]",
      desc:      "Username used to access the remote system. Used only for non-PowerStore systems.",
    },
    serial_number:          { 
      type:      "Optional[String]",
      desc:      "Serial number of the remote system instance.",
    },
    session_chap_mode:          { 
      type:      "Optional[Enum['Disabled','Single','Mutual']]",
      desc:      "Challenge Handshake Authentication Protocol (CHAP) status:* Disabled     * Single       - Enabled for initiator authentication.* Mutual       - Enabled for initiator and target authentication.",
      behaviour: :init_only,
    },
    session_chap_mode_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to session_chap_mode",
    },
    state:          { 
      type:      "Optional[Enum['OK','Update_Needed','Management_Connection_Lost']]",
      desc:      "Possible remote system states:    * OK                             - Normal conditions.* Update_Needed                  - Verify and update needed to handle network configuration changes on the systems.* Management_Connection_Lost     - Management connection to the remote peer is lost.",
    },
    state_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to state",
    },
    type:          { 
      type:      "Optional[Enum['PowerStore','Unity','VNX','PS_Equallogic','Storage_Center','XtremIO']]",
      desc:      "Remote system connection type between the local system and the following remote systems:      * PowerStore               - PowerStore system* Unity                    - Unity import system* VNX                      - VNX import system* PS_Equallogic            - PS EqualLogic import system* Storage_Center           - Storage Center import system* XtremIO                  - XtremIO import system",
      behaviour: :init_only,
    },
    type_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to type",
    },
    user_name:          { 
      type:      "Optional[String]",
      desc:      "Username used to access the non-PowerStore remote systems. ",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
