Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## Volume

Manage volumes, including snapshots and clones of volumes.

```puppet
powerstore_volume {
  appliance_id => "appliance_id (optional)",
  description => "description (optional)",
  expiration_timestamp => "expiration_timestamp (optional)",
  force => "force (optional)",
  host_group_id => "host_group_id (optional)",
  host_id => "host_id (optional)",
  is_replication_destination => "is_replication_destination (optional)",
  logical_unit_number => "logical_unit_number (optional)",
  min_size => "min_size (optional)",
  name => "name",
  node_affinity => "node_affinity (optional)",
  performance_policy_id => "performance_policy_id (optional)",
  protection_policy_id => "protection_policy_id (optional)",
  sector_size => "sector_size (optional)",
  size => "size (optional)",
  volume_group_id => "volume_group_id (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|appliance_id | Optional[String] | false |
|description | Optional[String[1,128]] | false |
|expiration_timestamp | Optional[String] | false |
|force | Optional[Boolean] | false |
|host_group_id | Optional[String] | false |
|host_id | Optional[String] | false |
|is_replication_destination | Optional[Boolean] | false |
|logical_unit_number | Optional[Integer[0,16383]] | false |
|min_size | Optional[Integer[0,9223372036854775807]] | false |
|name | String[1,128] | true |
|node_affinity | Optional[Enum['System_Select_At_Attach','System_Selected_Node_A','System_Selected_Node_B','Preferred_Node_A','Preferred_Node_B']] | false |
|performance_policy_id | Optional[String] | false |
|protection_policy_id | Optional[String] | false |
|sector_size | Optional[Integer[512,4096]] | false |
|size | Optional[Integer[1048576,281474976710656]] | false |
|volume_group_id | Optional[String] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the volume

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/volume`|Post|Create a volume on the appliance.|volume_create|
|List - list all|`/volume`|Get|Query volumes that are provisioned on the appliance.|volume_collection_query|
|List - get one|`/volume/%{id}`|Get|Query a specific volume instance.|volume_instance_query|
|List - get list using params|``||||
|Update|`/volume/%{id}`|Patch|Modify the parameters of a volume.|volume_modify|
|Delete|`/volume/%{id}`|Delete|Delete a volume. 

* A volume which is attached to a host or host group or is a member of a volume group cannot be deleted.
* A volume which has protection policies attached to it cannot be deleted.
* A volume which has snapshots that are part of a snapset cannot be deleted.
* Clones of a deleted production volume or a clone are not deleted.
* Snapshots of the volume are deleted along with the volume being deleted.|volume_delete|
