require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_physical_switch',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    connections:          {
      type:      'Optional[Array]',
      desc:      "Supported connections for a physical switch.",
      behaviour: :init_only,
    },
    id:          {
      type:      'String',
      desc:      "Unique identifier of the physical switch settings.",
      behaviour: :init_only,
    },
    name:          {
      type:      'Optional[String]',
      desc:      "Name of physical switch.",
      behaviour: :namevar,
    },
    purpose:          {
      type:      'Optional[String]',
      desc:      "Physical switch purpose in network. Possible purposes are:  * Data_and_Management - Physical switch for all data and management networks.  * Management_Only - Physical switch for management network only.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
