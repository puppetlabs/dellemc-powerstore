require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_file_virus_checker',
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
      desc:      "Unique identifier of the virus checker instance.",
      behaviour: :namevar,
    },
    is_enabled:          {
      type:      'Boolean',
      desc:      "Indicates whether the anti-virus service is enabled on this NAS server. Value are:- true - Anti-virus service is enabled. Each file created or modified by an SMB client is scanned by the third-party anti-virus servers. If a virus is detected, the access to the file system is denied. If third-party anti-virus servers are not available, according the policy, the access to the file systems is denied to prevent potential viruses propagation.- false - Anti-virus service is disabled. File systems of the NAS servers are available for access without virus checking.",
      behaviour: :init_only,
    },
    nas_server_id:          {
      type:      'String',
      desc:      "Unique identifier of an associated NAS Server instance that uses this virus checker configuration. Only one virus checker configuration per NAS Server is supported.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
