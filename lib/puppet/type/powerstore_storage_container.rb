require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_storage_container',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: "Enum['present', 'absent']",
      desc: "Whether this resource should be present or absent on the target system.",
      default: "present",
    },

    id:          {
      type:      "String",
      desc:      "Storage container ID.",
      behaviour: :init_only,
    },
    name:          {
      type:      "String[1,64]",
      desc:      "Name for the storage container that is unique across all storage containers in the cluster. The name must be between 1 and 64 UTF-8 characters (inclusive), and not more than 127 bytes.",
      behaviour: :namevar,
    },
    quota:          {
      type:      "Optional[Integer[0, 4611686018427387904]]",
      desc:      "The number of bytes that can be provisioned against this storage container. This must be a value greater than 10Gb and the default is 0 which means no limit.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
