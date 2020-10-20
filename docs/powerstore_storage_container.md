Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## Storage_container

Manage storage containers. A storage container is a logical grouping of related storage objects in a cluster. A storage container corresponds to a vVol datastore in vCenter and is used to group related vVols and track the amount of space that is used/free.

```puppet
powerstore_storage_container {
  force => "force (optional)",
  name => "name",
  quota => "quota (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|force | Optional[Boolean] | false |
|name | String[1,64] | true |
|quota | Optional[Integer[0,4611686018427387904]] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the storage_container

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/storage_container`|Post|Create a virtual volume (vVol) storage container.|storage_container_create|
|List - list all|`/storage_container`|Get|List storage containers.|storage_container_collection_query|
|List - get one|`/storage_container/%{id}`|Get|Query a specific instance of storage container.|storage_container_instance_query|
|List - get list using params|``||||
|Update|`/storage_container/%{id}`|Patch|Modify a storage container.|storage_container_modify|
|Delete|`/storage_container/%{id}`|Delete|Delete a storage container.|storage_container_delete|
