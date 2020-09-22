require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_file_kerberos',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    add_kdc_addresses:          {
      type:      'Optional[Array]',
      desc:      "Fully Qualified domain names of the Kerberos Key Distribution Center (KDC) servers to add to the current list. Error occurs if name already exists. Cannot be combined with kdc_addresses. IPv4 and IPv6 addresses are not supported.",
      behaviour: :init_only,
    },
    id:          {
      type:      'String',
      desc:      "Unique identifier of the Kerberos service object.",
      behaviour: :namevar,
    },
    kdc_addresses:          {
      type:      'Optional[Array]',
      desc:      "Fully Qualified domain names of the Kerberos Key Distribution Center (KDC) servers. IPv4 and IPv6 addresses are not supported.",
      behaviour: :init_only,
    },
    nas_server_id:          {
      type:      'String',
      desc:      "Unique identifier of the associated NAS Server instance that uses this Kerberos object. Only one Kerberos object per NAS Server is supported.",
      behaviour: :init_only,
    },
    port_number:          {
      type:      'Optional[Integer]',
      desc:      "KDC servers TCP port.",
      behaviour: :init_only,
    },
    realm:          {
      type:      'Optional[String]',
      desc:      "Realm name of the Kerberos Service.",
      behaviour: :init_only,
    },
    remove_kdc_addresses:          {
      type:      'Optional[Array]',
      desc:      "Fully Qualified domain names of the Kerberos Key Distribution Center (KDC) servers to remove from the current list. Error occurs if name is not in the existing list. Cannot be combined with kdc_addresses. IPv4 and IPv6 addresses are not supported.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
