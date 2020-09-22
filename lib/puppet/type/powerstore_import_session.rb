require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_import_session',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    automatic_cutover:          {
      type:      'Optional[Boolean]',
      desc:      "Indicates whether the import session cutover is manual (true) or automatic (false).",
      behaviour: :init_only,
    },
    description:          {
      type:      'Optional[String]',
      desc:      "Description of the import session. The name can contain a maximum of 128 unicode characters. It cannot contain unprintable characters.",
      behaviour: :init_only,
    },
    id:          {
      type:      'String',
      desc:      "Unique identifier of the import session",
      behaviour: :init_only,
    },
    name:          {
      type:      'String',
      desc:      "Name of the import session. The name must be unique in the PowerStore cluster and can contain a maximum of 128 unicode characters. It cannot contain special HTTP characters, unprintable characters, or white space.",
      behaviour: :namevar,
    },
    protection_policy_id:          {
      type:      'Optional[String]',
      desc:      "Unique identifier of the protection policy that will be applied to an imported volume or consistency group after the import completes. Only snapshot policies are supported in an import. Once the import completes, you can add a replication policy. If you try to import a replication policy, the import job will fail.",
      behaviour: :init_only,
    },
    remote_system_id:          {
      type:      'String',
      desc:      "Unique identifier of the storage system that contains the source volume or consistency group to be imported. You can query the source volume or consistency group object to get the identifier of the source system that the volume or consistency group are part of. Alternatively, you can use the remote_system object to get this information.",
      behaviour: :init_only,
    },
    scheduled_timestamp:          {
      type:      'Optional[String]',
      desc:      "Indicates the new date and time at which the import session is scheduled to run. The date is specified in ISO 8601 format with time expressed in UTC format.",
      behaviour: :init_only,
    },
    source_resource_id:          {
      type:      'String',
      desc:      "Unique identifier of the volume or consistency group to be imported. Refer to the following objects for more information: * Storage Center : import_storage_center_volume, import_storage_center_consistency_group * VNX : import_vnx_volume, import_vnx_consistency_group * PS Series : import_psgroup_volume * Unity : import_unity_volume, import_unity_consistency_group",
      behaviour: :init_only,
    },
    volume_group_id:          {
      type:      'Optional[String]',
      desc:      "Unique identifier of the volume group to which the imported volume will belong, if any.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
