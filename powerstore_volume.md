Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## Volume



```puppet
powerstore_volume {
  appliance_id => "appliance_id (optional)",
  description => "description (optional)",
  expiration_timestamp => "expiration_timestamp (optional)",
  force => "force (optional)",
  host_group_id => "host_group_id (optional)",
  host_id => "host_id (optional)",
  id => "id",
  is_replication_destination => "is_replication_destination (optional)",
  logical_unit_number => "1234 (optional)",
  min_size => "1234 (optional)",
  name => "name (optional)",
  node_affinity => "node_affinity (optional)",
  performance_policy_id => "performance_policy_id (optional)",
  protection_policy_id => "protection_policy_id (optional)",
  sector_size => "1234 (optional)",
  size => "1234 (optional)",
  volume_group_id => "volume_group_id (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|appliance_id | String | false |
|description | String | false |
|expiration_timestamp | String | false |
|force | Boolean | false |
|host_group_id | String | false |
|host_id | String | false |
|id | String | true |
|is_replication_destination | Boolean | false |
|logical_unit_number | Integer | false |
|min_size | Integer | false |
|name | String | false |
|node_affinity | String | false |
|performance_policy_id | String | false |
|protection_policy_id | String | false |
|sector_size | Integer | false |
|size | Integer | false |
|volume_group_id | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the volume

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/volume`|Post|Create a volume on the appliance.|volumeCreate|
|List - list all|`/volume`|Get|Query volumes that are provisioned on the appliance.|volumeCollectionQuery|
|List - get one|`/volume/%{id}`|Get|Query a specific volume instance.|volumeInstanceQuery|
|List - get list using params|``||||
|Update|`/volume/%{id}`|Patch|Modify the parameters of a volume.|volumeModify|
|Delete|`/volume/%{id}`|Delete|Delete a volume. 

* A volume which is attached to a host or host group or is a member of a volume group cannot be deleted.
* A volume which has protection policies attached to it cannot be deleted.
* A volume which has snapshots that are part of a snapset cannot be deleted.
* Clones of a deleted production volume or a clone are not deleted.
* Snapshots of the volume are deleted along with the volume being deleted.|volumeDelete|
