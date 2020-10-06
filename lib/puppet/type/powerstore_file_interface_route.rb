require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_file_interface_route',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: "Enum['present', 'absent']",
      desc: "Whether this resource should be present or absent on the target system.",
      default: "present",
    },

    destination:          {
      type:      "Optional[String]",
      desc:      "IPv4 or IPv6 address of the target network node based on the specific route type. Values are:* For a default route, there is no value because the system will use the specified gateway IP address.* For a host route, the value is the host IP address.* For a subnet route, the value is a subnet IP address.",
    },
    file_interface_id:          {
      type:      "String",
      desc:      "Unique identifier of the associated file interface.",
      behaviour: :init_only,
    },
    gateway:          {
      type:      "Optional[String[1,45]]",
      desc:      "IP address of the gateway associated with the route.",
    },
    id:          {
      type:      "String",
      desc:      "Unique identifier of the file interface route object.",
      behaviour: :namevar,
    },
    prefix_length:          {
      type:      "Optional[Integer[1, 128]]",
      desc:      "IPv4 or IPv6 prefix length for the route.",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
