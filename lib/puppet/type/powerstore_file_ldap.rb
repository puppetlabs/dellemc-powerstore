require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_file_ldap',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    add_addresses:          {
      type:      'Optional[Array]',
      desc:      "IP addresses to add to the current server IP addresses list. The addresses may be IPv4 or IPv6. Error occurs if an IP address already exists in the addresses list. Cannot be combined with addresses.",
      behaviour: :init_only,
    },
    addresses:          {
      type:      'Optional[Array]',
      desc:      "The list of LDAP server IP addresses. The addresses may be IPv4 or IPv6.",
      behaviour: :init_only,
    },
    authentication_type:          {
      type:      'Optional[String]',
      desc:      "Authentication type for the LDAP server.* Anonymous - Anonymous authentication means no authentication occurs and the NAS Server uses an anonymous login to access the LDAP-based directory server.* Simple - Simple authentication means the NAS Server must provide a bind distinguished name and password to access the LDAP-based directory server.* Kerberos - Kerberos authentication means the NAS Server uses a KDC to confirm the identity when accessing the Active Directory.",
      behaviour: :init_only,
    },
    base_dn:          {
      type:      'Optional[String]',
      desc:      "Name of the LDAP base DN. Base Distinguished Name (BDN) of the root of the LDAP directory tree. The appliance uses the DN to bind to the LDAP service and locate in the LDAP directory tree to begin a search for information.  The base DN can be expressed as a fully-qualified domain name or in X.509 format by using the attribute dc=. For example, if the fully-qualified domain name is mycompany.com, the base DN is expressed as dc=mycompany,dc=com.",
      behaviour: :init_only,
    },
    bind_dn:          {
      type:      'Optional[String]',
      desc:      "Bind Distinguished Name (DN) to be used when binding.",
      behaviour: :init_only,
    },
    bind_password:          {
      type:      'Optional[String]',
      desc:      "The associated password to be used when binding to the server.",
      behaviour: :init_only,
    },
    id:          {
      type:      'String',
      desc:      "Unique identifier of the LDAP settings object id.",
      behaviour: :namevar,
    },
    is_smb_account_used:          {
      type:      'Optional[Boolean]',
      desc:      "Indicates whether SMB authentication is used to authenticate to the LDAP server. Values are:     * true - Indicates that the SMB settings are used for Kerberos authentication.    * false - Indicates that Kerberos uses its own settings.",
      behaviour: :init_only,
    },
    is_verify_server_certificate:          {
      type:      'Optional[Boolean]',
      desc:      "Indicates whether Certification Authority certificate is used to verify the LDAP server certificate for secure SSL connections. Values are: * true - verifies LDAP server's certificate. * false - doesn't verify LDAP server's certificate.",
      behaviour: :init_only,
    },
    nas_server_id:          {
      type:      'String',
      desc:      "Unique identifier of the associated NAS Server instance that will use this LDAP object. Only one LDAP object per NAS Server is supported.",
      behaviour: :init_only,
    },
    password:          {
      type:      'Optional[String]',
      desc:      "The associated password for Kerberos authentication.",
      behaviour: :init_only,
    },
    port_number:          {
      type:      'Optional[Integer]',
      desc:      "The TCP/IP port used by the NAS Server to connect to the LDAP servers.",
      behaviour: :init_only,
    },
    principal:          {
      type:      'Optional[String]',
      desc:      "Specifies the principal name for Kerberos authentication.",
      behaviour: :init_only,
    },
    profile_dn:          {
      type:      'Optional[String]',
      desc:      "For an iPlanet LDAP server, specifies the DN of the entry with the configuration profile.",
      behaviour: :init_only,
    },
    protocol:          {
      type:      'Optional[String]',
      desc:      "Indicates whether the LDAP protocol uses SSL for secure network communication. SSL encrypts data over the network and provides message and server authentication.* LDAP - LDAP protocol without SSL.* LDAPS - (Default) LDAP protocol with SSL. When you enable LDAPS, make sure to specify the appropriate LDAPS port (usually port 636) and to upload an LDAPS trust certificate to the LDAP server.",
      behaviour: :init_only,
    },
    realm:          {
      type:      'Optional[String]',
      desc:      "Specifies the realm name for Kerberos authentication.",
      behaviour: :init_only,
    },
    remove_addresses:          {
      type:      'Optional[Array]',
      desc:      "IP addresses to remove from the current server IP addresses list. The addresses may be IPv4 or IPv6. Error occurs if an IP address does not exist in the addresses_list. Cannot be combined with addresses.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
