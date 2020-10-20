require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_file_interface_route',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    Use these resources to manage static IP routes, including creating, modifying, and deleting these routes.

A route determines where to send a packet next so it can reach its final destination. A static route is set explicitly and does not automatically adapt to the changing network infrastructure. A route is defined by an interface, destination IP address range and an IP address of a corresponding gateway.

**Note**: IP routes connect an interface (IP address) to the larger network through gateways. Without routes and gateway specified, the interface is no longer accessible outside of its immediate subnet. As a result, network shares and exports associated with the interface are no longer available to clients outside their immediate subnet.

  EOS
  attributes:   {
    ensure:      {
      type:      "Enum['present', 'absent']",
      desc:      "Whether this resource should be present or absent on the target system.",
      default:   "present",
    },
    destination:          { 
      type:      "Optional[String]",
      desc:      "IPv4 or IPv6 address of the target network node based on the specific route type. Values are:* For a default route, there is no value because the system will use the specified gateway IP address.* For a host route, the value is the host IP address.* For a subnet route, the value is a subnet IP address.",
    },
    file_interface_id:          { 
      type:      "Optional[String]",
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
    operational_status:          { 
      type:      "Optional[Enum['Ok','Invalid_IP_Version','Invalid_Source_Interface','Invalid_Gateway','Not_Operational']]",
      desc:      "File interface route Operational Status:* Ok - the route is working fine.* Invalid_IP_Version - source interfaces have a different IP protocol version than the route.* Invalid_Source_Interface - no source interfaces set up on the system.* Invalid_Gateway - source interfaces in a different subnet than the gateway.* Not_Operational - the route is not operational.",
    },
    operational_status_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to operational_status",
    },
    prefix_length:          { 
      type:      "Optional[Integer[1,128]]",
      desc:      "IPv4 or IPv6 prefix length for the route.",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
