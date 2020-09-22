require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_file_ndmp',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    id:          {
      type:      'String',
      desc:      "Unique identifier of the NDMP service object.",
      behaviour: :namevar,
    },
    nas_server_id:          {
      type:      'String',
      desc:      "Unique identifier of the NAS server to be configured with these NDMP settings.",
      behaviour: :init_only,
    },
    password:          {
      type:      'Optional[String]',
      desc:      "Password for the NDMP service user.",
      behaviour: :init_only,
    },
    user_name:          {
      type:      'Optional[String]',
      desc:      "User name for accessing the NDMP service.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
