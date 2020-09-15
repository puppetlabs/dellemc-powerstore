Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## Volume_group



```puppet
powerstore_volume_group {
  description => "description (optional)",
  force => "force (optional)",
  is_replication_destination => "is_replication_destination (optional)",
  is_write_order_consistent => "is_write_order_consistent (optional)",
  name => "name (optional)",
  protection_policy_id => "protection_policy_id (optional)",
  volume_ids => "volume_ids (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|description | String | false |
|force | Boolean | false |
|is_replication_destination | Boolean | false |
|is_write_order_consistent | Boolean | false |
|name | String | false |
|protection_policy_id | String | false |
|volume_ids | Array | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the volume_group

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/volume_group`|Post|Create a new volume group. The resulting volume group will have a type of Primary.
|volume_groupCreate|
|List - list all|`/volume_group`|Get|Query all volume groups, including snapshot sets and clones of volume groups.
|volume_groupCollectionQuery|
|List - get one|`/volume_group/%{id}`|Get|Query a specific volume group, snapshot set, or clone.|volume_groupInstanceQuery|
|List - get list using params|``||||
|Update|`/volume_group/%{id}`|Patch|Modify a volume group, snapshot set, or clone.|volume_groupModify|
|Delete|`/volume_group/%{id}`|Delete|Delete a volume group, snapshot set, or clone.
Before you try deleting a volume group, snapshot set, or clone, ensure that you first detach it from all hosts. Note the following:
* When a volume group or clone is deleted, all related snapshot sets will also be deleted.
* When a snapshot set is deleted, all of its constituent snapshots will also be deleted.
|volume_groupDelete|
