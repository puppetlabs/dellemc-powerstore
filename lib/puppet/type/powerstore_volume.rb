require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_volume',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    appliance_id:          {
      type:      'Optional[String]',
      desc:      "Identifier of the appliance on which the volume is provisioned.",
      behaviour: :init_only,
    },
    description:          {
      type:      'Optional[String]',
      desc:      "New description of the volume. This value must contain 128 or fewer printable Unicode characters.",
      behaviour: :init_only,
    },
    expiration_timestamp:          {
      type:      'Optional[String]',
      desc:      "New expiration time of the snapshot. Expired snapshots are deleted by the snapshot aging service that runs periodically in the background. If not specified, the snapshot never expires.Use a maximum timestamp value to set an expiration to never expire.",
      behaviour: :init_only,
    },
    force:          {
      type:      'Optional[Boolean]',
      desc:      "Normally a replication destination volume cannot be modified since it is controlled by replication. However, there can be cases where replication has failed or is no longer active and the replication destination volume needs to be cleaned up.With the force option, the user will be allowed to remove the protection policy from the replication destination volume provided that the replication session has never been synchronized and the last_sync_timestamp property is empty.This parameter defaults to false, if not specified.",
      behaviour: :init_only,
    },
    host_group_id:          {
      type:      'Optional[String]',
      desc:      "Unique identifier of the host group to be attached to the volume. If not specified, an unmapped volume is created. Only one of host_id or host_group_id can be supplied.",
      behaviour: :init_only,
    },
    host_id:          {
      type:      'Optional[String]',
      desc:      "Unique identifier of the host to be attached to the volume. If not specified, an unmapped volume is created. Only one of host_id or host_group_id can be supplied.",
      behaviour: :init_only,
    },
    id:          {
      type:      'String',
      desc:      "Unique identifier of the volume to query.",
      behaviour: :init_only,
    },
    is_replication_destination:          {
      type:      'Optional[Boolean]',
      desc:      "New value for is_replication_destination property. The modification is only supported for primary and clone volume, only when the current value is true and there is no longer a replication session using this volume as a destination, and only to false.",
      behaviour: :init_only,
    },
    logical_unit_number:          {
      type:      'Optional[Integer]',
      desc:      "Optional logical unit number when creating a  attached volume.  If no host_id or host_group_id is specified, this property is ignored.",
      behaviour: :init_only,
    },
    min_size:          {
      type:      'Optional[Integer]',
      desc:      "Optional minimum size for the volume, in bytes.",
      behaviour: :init_only,
    },
    name:          {
      type:      'Optional[String]',
      desc:      "New name of the volume. This value must contain 128 or fewer printable Unicode characters.",
      behaviour: :namevar,
    },
    node_affinity:          {
      type:      'Optional[String]',
      desc:      "This attribute shows which node will be advertised as the optimized IO path to the volume. It is initially set to System_Select_At_Attach and can be modified to other values. When a volume is first attached to a host, if node_affinity is System_Select_At_Attach then the system will make the assignment to either System_Selected_Node_A or System_Selected_Node_B. The node_affinity may be modified to one of System_Select_At_Attach or Preferred_Node_A or Preferred_Node_B. Both System_Selected_Node_A and System_Selected_Node_B are reserved for system use only and cannot be set as the volume's node_affinity.Possible affinity for a volume. * System_Select_At_Attach - Volume currently has no node affinity, affinity will be assigned when the volume is first attached. * System_Selected_Node_A - System selected Node A as the optimized IO path to volume. * System_Selected_Node_B - System selected Node B as the optimized IO path to volume. * Preferred_Node_A - Node A will always advertise as the optimized IO path to volume. * Preferred_Node_B - Node B will always advertise as the optimized IO path to volume.",
      behaviour: :init_only,
    },
    performance_policy_id:          {
      type:      'Optional[String]',
      desc:      "Unique identifier of the performance policy assigned to the volume.",
      behaviour: :init_only,
    },
    protection_policy_id:          {
      type:      'Optional[String]',
      desc:      "Unique identifier of the protection policy assigned to the volume.",
      behaviour: :init_only,
    },
    sector_size:          {
      type:      'Optional[Integer]',
      desc:      "Optional sector size, in bytes. Only 512-byte and 4096-byte sectors are supported.",
      behaviour: :init_only,
    },
    size:          {
      type:      'Optional[Integer]',
      desc:      "New size of the volume in bytes,  must be a multiple of 8192, must be bigger than the current volume size. Maximum volume size is 256TB.",
      behaviour: :init_only,
    },
    volume_group_id:          {
      type:      'Optional[String]',
      desc:      "Volume group to add the volume to.  If not specified, the volume is not added to a volume group.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
