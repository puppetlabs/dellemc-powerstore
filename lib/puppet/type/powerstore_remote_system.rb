require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_remote_system',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    data_network_latency:          {
      type:      'Optional[String]',
      desc:      "Network latency choices for a remote system. Replication traffic can be tuned for higher efficiency depending on the expected network latency. This will only be used when the remote system type is PowerStore.* Low                      - Less than 5 milliseconds.* High                     - More than 5 milliseconds.",
      behaviour: :init_only,
    },
    description:          {
      type:      'Optional[String]',
      desc:      "User-specified description of the remote system.",
      behaviour: :init_only,
    },
    discovery_chap_mode:          {
      type:      'Optional[String]',
      desc:      "Challenge Handshake Authentication Protocol (CHAP) status:* Disabled     * Single       - Enabled for initiator authentication.* Mutual       - Enabled for initiator and target authentication.",
      behaviour: :init_only,
    },
    import_chap_info:          {
      type:      'Optional[Hash]',
      desc:      "Information about the initiator, target session, or discovery CHAP secrets.",
      behaviour: :init_only,
    },
    iscsi_addresses:          {
      type:      'Optional[Array]',
      desc:      "iSCSI target IP addresses for the data connection to the remote system. Must be specified when creating a non-PowerStore remote system.",
      behaviour: :init_only,
    },
    management_address:          {
      type:      'Optional[String]',
      desc:      "Management IP address of the remote system.",
      behaviour: :init_only,
    },
    name:          {
      type:      'Optional[String]',
      desc:      "User-specified name of the remote system. Used only for non-PowerStore type remote systems. This value must contain 128 or fewer printable Unicode characters.",
      behaviour: :namevar,
    },
    remote_password:          {
      type:      'Optional[String]',
      desc:      "Password used to access the remote system. Used only for non-PowerStore systems.",
      behaviour: :init_only,
    },
    remote_username:          {
      type:      'Optional[String]',
      desc:      "Username used to access the remote system. Used only for non-PowerStore systems.",
      behaviour: :init_only,
    },
    session_chap_mode:          {
      type:      'Optional[String]',
      desc:      "Challenge Handshake Authentication Protocol (CHAP) status:* Disabled     * Single       - Enabled for initiator authentication.* Mutual       - Enabled for initiator and target authentication.",
      behaviour: :init_only,
    },
    type:          {
      type:      'Optional[String]',
      desc:      "Remote system connection type between the local system and the following remote systems:      * PowerStore               - PowerStore system* Unity                    - Unity import system* VNX                      - VNX import system* PS_Equallogic            - PS EqualLogic import system* Storage_Center           - Storage Center import system* XtremIO                  - XtremIO import system",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
