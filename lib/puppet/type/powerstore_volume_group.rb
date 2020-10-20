require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_volume_group',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    Manage volume_groups. A volume_group is a group of related volumes treated as a single unit. It can optionally be write-order consistent.
  EOS
  attributes:   {
    ensure:      {
      type:      "Enum['present', 'absent']",
      desc:      "Whether this resource should be present or absent on the target system.",
      default:   "present",
    },
    creation_timestamp:          { 
      type:      "Optional[String]",
      desc:      "The time at which the volume group was created.",
    },
    delete_members:          { 
      type:      "Optional[Boolean]",
      desc:      "By default, the members of a volume group being deleted are only removed. Set this optional parameter to true to override this behavior and also delete the members after they are removed from the volume group.This parameter defaults to false, if not specified.",
      default:   false,
      behaviour: :parameter,
    },
    description:          { 
      type:      "Optional[String[1,256]]",
      desc:      "Description for the volume group. The description should not be more than 256characters long and should not have any unprintable characters.If description is not specified, the description for the volume group will not be set.",
    },
    force:          { 
      type:      "Optional[Boolean]",
      desc:      "Normally a replication destination volume group cannot be modified since it is controlled by replication. However, there can be cases where replication has failed or is no longer active and the replication destination volume group needs to be cleaned up.With the force option, the user will be allowed to remove the protection policy from the replication destination volume group provided that the replication session has never been synchronized.This parameter defaults to false, if not specified.",
      default:   false,
    },
    id:          { 
      type:      "String",
      desc:      "Unique identifier of the volume group.",
      behaviour: :read_only,
    },
    is_importing:          { 
      type:      "Optional[Boolean]",
      desc:      "Indicates whether the volume group is being imported.",
    },
    is_protectable:          { 
      type:      "Optional[Boolean]",
      desc:      "This is a derived field that is set internally. It enables/disables the following functionality:* Whether a protection_policy can be applied to the group.* Whether manual snapshots can be taken.* Whether clones of the group can be created.",
    },
    is_replication_destination:          { 
      type:      "Optional[Boolean]",
      desc:      "New value for is_replication_destination property. is_replication_destination property of all the volumes in the volume group will be modified to the specified value. Modification of is_replication will not be transactional in nature. If the command only succeeds in modifying the is_replication_destination property of a subset of volumes, is_replication_destination property for the volume group will be set to true.Modification of this property is idempotent.This parameter is only valid when modifying a primary or a clone volume group, only when the volume group is no longer the destination of a replication session, and may only be set to false.",
    },
    is_write_order_consistent:          { 
      type:      "Optional[Boolean]",
      desc:      "A boolean flag to indicate whether snapshot sets of the volume group will be write-order consistent.This parameter defaults to true, if not specified.",
      default:   true,
    },
    location_history:          { 
      type:      "Optional[Array[Struct[{Optional[from_appliance_id] => String, Optional[migrated_on] => String, Optional[reason] => Enum['Initial','Manual','Recommended'], Optional[reason_l10n] => String, Optional[to_appliance_id] => String, }]]]",
      desc:      "A list of locations. The list of locations includes the move to the current appliance. Filtering on the fields of this embedded resource is not supported.",
    },
    migration_session_id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of the migration session assigned to the volume group when it is part of a migration activity.",
    },
    name:          { 
      type:      "String[1,128]",
      desc:      "Unique name for the volume group. The name should contain no special HTTP characters and no unprintable characters. Although the case of the name provided is reserved, uniqueness check is case-insensitive, so the same name in two different cases is not considered unique.",
      behaviour: :namevar,
    },
    placement_rule:          { 
      type:      "Optional[Enum['Same_Appliance','No_Preference']]",
      desc:      "This is set during creation, and determines resource balancer recommendations.* Same_Appliance - All the members of the group should be on the same appliance in the cluster.* No_Preference - The volumes can be placed on any of the appliances in the cluster. Filtering on the fields of this embedded resource is not supported.",
    },
    protection_data:          { 
      type:      "Optional[Struct[{Optional[copy_signature] => String, Optional[created_by_rule_id] => String, Optional[created_by_rule_name] => String, Optional[creator_type] => Enum['User','System','Scheduler'], Optional[creator_type_l10n] => String, Optional[expiration_timestamp] => String, Optional[family_id] => String, Optional[is_app_consistent] => Boolean, Optional[parent_id] => String, Optional[source_id] => String, Optional[source_timestamp] => String, }]]",
      desc:      "Protection data associated with a resource. Filtering on the fields of this embedded resource is not supported.",
    },
    protection_policy_id:          { 
      type:      "Optional[String]",
      desc:      "Unique identifier of an optional protection policy to assign to the volume group.",
    },
    type:          { 
      type:      "Optional[Enum['Primary','Clone','Snapshot']]",
      desc:      "Type of volume. * Primary - A base object. * Clone - A read-write object that shares storage with the object from which it is sourced. * Snapshot - A read-only object created from a volume or clone.",
    },
    type_l10n:          { 
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to type",
    },
    volume_ids:          { 
      type:      "Optional[Array[String]]",
      desc:      "A list of identifiers of existing volumes that should be added to the volume group. All the volumes must be on the same Cyclone appliance and should not be part of another volume group.If a list of volumes is not specified or if the specified list is empty, anempty volume group of type Volume will be created.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
