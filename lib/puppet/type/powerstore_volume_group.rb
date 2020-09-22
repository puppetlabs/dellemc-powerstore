require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_volume_group',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    description:          {
      type:      'Optional[String]',
      desc:      "New description for the volume group. The description should not have any unprintable characters.If an empty string is specified, the description will be cleared.",
      behaviour: :init_only,
    },
    force:          {
      type:      'Optional[Boolean]',
      desc:      "Normally a replication destination volume group cannot be modified since it is controlled by replication. However, there can be cases where replication has failed or is no longer active and the replication destination volume group needs to be cleaned up.With the force option, the user will be allowed to remove the protection policy from the replication destination volume group provided that the replication session has never been synchronized.This parameter defaults to false, if not specified.",
      behaviour: :init_only,
    },
    is_replication_destination:          {
      type:      'Optional[Boolean]',
      desc:      "New value for is_replication_destination property. is_replication_destination property of all the volumes in the volume group will be modified to the specified value. Modification of is_replication will not be transactional in nature. If the command only succeeds in modifying the is_replication_destination property of a subset of volumes, is_replication_destination property for the volume group will be set to true.Modification of this property is idempotent.This parameter is only valid when modifying a primary or a clone volume group, only when the volume group is no longer the destination of a replication session, and may only be set to false.",
      behaviour: :init_only,
    },
    is_write_order_consistent:          {
      type:      'Optional[Boolean]',
      desc:      "A boolean flag to indicate whether snapshot sets of the volume group will be write-order consistent.This parameter is only valid when modifying a primary or a clone volume group.",
      behaviour: :init_only,
    },
    name:          {
      type:      'Optional[String]',
      desc:      "New name for the volume group. The name should contain no special HTTP characters and no unprintable characters. Although the case of the name provided is reserved, uniqueness check is case-insensitive, so the same name in two different cases is not considered unique.",
      behaviour: :namevar,
    },
    protection_policy_id:          {
      type:      'Optional[String]',
      desc:      "Unique identifier of the protection policy to assign to a primary or clone volume group. If an empty string is specified, protection policy will be removed from the volume group.",
      behaviour: :init_only,
    },
    volume_ids:          {
      type:      'Optional[Array]',
      desc:      "A list of identifiers of existing volumes that should be added to the volume group. All the volumes must be on the same Cyclone appliance and should not be part of another volume group.If a list of volumes is not specified or if the specified list is empty, anempty volume group of type Volume will be created.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
