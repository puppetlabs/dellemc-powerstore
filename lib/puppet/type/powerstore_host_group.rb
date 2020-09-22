require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_host_group',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    add_host_ids:          {
      type:      'Optional[Array]',
      desc:      "List of hosts to be added to host group. The operation fails if the host(s) to be added are attached to volume.",
      behaviour: :init_only,
    },
    description:          {
      type:      'Optional[String]',
      desc:      "An optional description for the host group. The description should not be more than 256 UTF-8  characters long and should not have any unprintable characters.",
      behaviour: :init_only,
    },
    host_ids:          {
      type:      'Array',
      desc:      "",
      behaviour: :init_only,
    },
    id:          {
      type:      'String',
      desc:      "Unique id of the host group.",
      behaviour: :init_only,
    },
    name:          {
      type:      'Optional[String]',
      desc:      "A new host group name. The name should not be more than 128 UTF-8 characters long and should not have any unprintable characters.",
      behaviour: :namevar,
    },
    remove_host_ids:          {
      type:      'Optional[Array]',
      desc:      "List of hosts to be removed from the host group. The operation fails if host group is attached to volume.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
