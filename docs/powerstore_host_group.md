Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## Host_group

Manage host groups.
 A host group is a mechanism to provision hosts and volumes to be consistent across the Cyclone cluster. Operations that can be performed include, creating or deleting a host group, modifying host group(i.e. adding or removing hosts from a host group).

```puppet
powerstore_host_group {
  add_host_ids => "add_host_ids (optional)",
  description => "description (optional)",
  host_ids => "host_ids (optional)",
  name => "name",
  remove_host_ids => "remove_host_ids (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|add_host_ids | Optional[Array[String]] | false |
|description | Optional[String[1,256]] | false |
|host_ids | Optional[Array[String]] | false |
|name | String[1,128] | true |
|remove_host_ids | Optional[Array[String]] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the host_group

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/host_group`|Post|Create a host group.|host_group_create|
|List - list all|`/host_group`|Get|List host groups.|host_group_collection_query|
|List - get one|`/host_group/%{id}`|Get|Get details about a specific host group.|host_group_instance_query|
|List - get list using params|``||||
|Update|`/host_group/%{id}`|Patch|Operations that can be performed are modify name, remove host(s) from host group, add host(s) to host group. Modify request will only support either a add_host(s) or remove_host(s) at a time along with modifying host name|host_group_modify|
|Delete|`/host_group/%{id}`|Delete|Delete a host group. Delete fails if host group is attached to a volume.|host_group_delete|
