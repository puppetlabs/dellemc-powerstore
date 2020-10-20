require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_physical_switch',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    Manage physical switches settings for the cluster.
  EOS
  attributes:   {
    ensure:      {
      type:      "Enum['present', 'absent']",
      desc:      "Whether this resource should be present or absent on the target system.",
      default:   "present",
    },
    connections:          { 
      type:      "Optional[Array[Struct[{address => Optional[String[1,255]], connect_method => Optional[Enum['SSH','SNMPv2c']], Optional[port] => Optional[Integer[0,65535]], Optional[snmp_community_string] => Optional[String[1,128]], Optional[ssh_password] => Optional[String[1,128]], Optional[username] => Optional[String[1,128]], }]]]",
      desc:      "Supported connections for a physical switch.",
    },
    id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of the physical switch settings.",
      behaviour: :read_only,
    },
    name:          { 
      type:      "String[1,128]",
      desc:      "Name of a physical switch.",
      behaviour: :namevar,
    },
    purpose:          { 
      type:      "Optional[Enum['Data_and_Management','Management_Only']]",
      desc:      "Physical switch purpose in network. Possible purposes are:  * Data_and_Management - Physical switch for all data and management networks.  * Management_Only - Physical switch for management network only.",
    },
    purpose_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to purpose",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
