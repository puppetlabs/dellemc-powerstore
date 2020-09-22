require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_vcenter',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    address:          {
      type:      'Optional[String]',
      desc:      "IP address of vCenter host, in IPv4, IPv6, or hostname format. Must be a new address of the same vCenter.",
      behaviour: :init_only,
    },
    id:          {
      type:      'String',
      desc:      "Unique identifier of the vCenter to modify.",
      behaviour: :namevar,
    },
    password:          {
      type:      'Optional[String]',
      desc:      "Password to login to vCenter.",
      behaviour: :init_only,
    },
    username:          {
      type:      'Optional[String]',
      desc:      "User name to login to vCenter. Password needs to be provided to modify the user name.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
