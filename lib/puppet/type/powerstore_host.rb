require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_host',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    add_initiators:          {
      type:      'Optional[Array]',
      desc:      "The list of initiators to be added. CHAP username and password are optional.",
      behaviour: :init_only,
    },
    description:          {
      type:      'Optional[String]',
      desc:      "An optional description for the host. The description should not be more than 256 UTF-8 characters long and should not have any unprintable characters.",
      behaviour: :init_only,
    },
    id:          {
      type:      'String',
      desc:      "Unique id of the host.",
      behaviour: :init_only,
    },
    initiators:          {
      type:      'Array',
      desc:      "",
      behaviour: :init_only,
    },
    modify_initiators:          {
      type:      'Optional[Array]',
      desc:      "Update list of existing initiators, identified by port_name, with new CHAP usernames and/or passwords.",
      behaviour: :init_only,
    },
    name:          {
      type:      'Optional[String]',
      desc:      "The host name. The name should not be more than 128 UTF-8 characters long and should not have any unprintable characters.",
      behaviour: :namevar,
    },
    os_type:          {
      type:      'String',
      desc:      "Operating system of the host.",
      behaviour: :init_only,
    },
    remove_initiators:          {
      type:      'Optional[Array]',
      desc:      "The list of initiator port_names to be removed.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
