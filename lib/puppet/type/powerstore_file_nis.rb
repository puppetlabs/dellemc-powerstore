require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_file_nis',
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
      desc:      "IP addresses to add to the current list. The addresses may be IPv4 or IPv6. Error occurs if the IP address already exists. Cannot be combined with ip_addresses.",
    },
    domain:          {
      type:      "String[1,255]",
      desc:      "Name of the NIS domain.",
    },
    id:          {
      type:      "String",
      desc:      "Unique identifier of the NIS object.",
      behaviour: :namevar,
    },
    ip_addresses:          {
      type:      "Array[String]",
      desc:      "The list of NIS server IP addresses.",
    },
    nas_server_id:          {
      type:      "String",
      desc:      "Unique identifier of the associated NAS Server instance that uses this NIS Service object.  Only one NIS Service per NAS Server is supported.",
      behaviour: :init_only,
    },
    remove_ip_addresses:          {
      type:      "Optional[Array[String]]",
      desc:      "IP addresses to remove from the current list. The addresses may be IPv4 or IPv6. Error occurs if the IP address is not present. Cannot be combined with ip_addresses.",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
