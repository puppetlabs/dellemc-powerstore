require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_file_dns',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: "Enum['present', 'absent']",
      desc: "Whether this resource should be present or absent on the target system.",
      default: "present",
    },

    add_ip_addresses:          {
      type:      "Optional[Array[String]]",
      desc:      "IP addresses to add to the current list. The addresses may be IPv4 or IPv6. Error occurs if an IP address already exists. Cannot be combined with ip_addresses.",
    },
    domain:          {
      type:      "String[1,255]",
      desc:      "Name of the DNS domain, where the NAS Server does host names lookup when an FQDN is not specified in the request.",
    },
    id:          {
      type:      "String",
      desc:      "Unique identifier of the DNS object.",
      behaviour: :namevar,
    },
    ip_addresses:          {
      type:      "Array[String]",
      desc:      "The list of DNS server IP addresses. The addresses may be IPv4 or IPv6.",
    },
    nas_server_id:          {
      type:      "String",
      desc:      "Unique identifier of the associated NAS Server instance that uses this DNS object. Only one DNS object per NAS Server is supported.",
      behaviour: :init_only,
    },
    remove_ip_addresses:          {
      type:      "Optional[Array[String]]",
      desc:      "IP addresses to remove from the current list. The addresses may be IPv4 or IPv6. Error occurs if IP address is not present. Cannot be combined with ip_addresses.",
    },
    transport:          {
      type:      "Optional[Enum['UDP','TCP']]",
      desc:      "Transport used when connecting to the DNS Server:* UDP - DNS uses the UDP protocol (default)* TCP - DNS uses the TCP protocol",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
