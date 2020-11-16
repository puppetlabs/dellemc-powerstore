Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## Volume_group

Manage volume_groups. A volume_group is a group of related volumes treated as a single unit. It can optionally be write-order consistent.

```puppet
powerstore_volume_group {
  delete_members => "delete_members (optional)",
  description => "description (optional)",
  force => "force (optional)",
  is_replication_destination => "is_replication_destination (optional)",
  is_write_order_consistent => "is_write_order_consistent (optional)",
  name => "name",
  protection_policy_id => "protection_policy_id (optional)",
  volume_ids => "volume_ids (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|delete_members | Optional[Boolean] | false |
|description | Optional[String[0,256]] | false |
|force | Optional[Boolean] | false |
|is_replication_destination | Optional[Boolean] | false |
|is_write_order_consistent | Optional[Boolean] | false |
|name | String[0,128] | true |
|protection_policy_id | Optional[String] | false |
|volume_ids | Optional[Array[String]] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the volume_group

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/volume_group`|Post|Create a new volume group. The resulting volume group will have a type of Primary.
|volume_group_create|
|List - list all|`/volume_group`|Get|Query all volume groups, including snapshot sets and clones of volume groups.
|volume_group_collection_query|
|List - get one|`/volume_group/%{id}`|Get|Query a specific volume group, snapshot set, or clone.|volume_group_instance_query|
|List - get list using params|``||||
|Update|`/volume_group/%{id}`|Patch|Modify a volume group, snapshot set, or clone.|volume_group_modify|
|Delete|`/volume_group/%{id}`|Delete|Delete a volume group, snapshot set, or clone.
Before you try deleting a volume group, snapshot set, or clone, ensure that you first detach it from all hosts. Note the following:
* When a volume group or clone is deleted, all related snapshot sets will also be deleted.
* When a snapshot set is deleted, all of its constituent snapshots will also be deleted.
|volume_group_delete|
