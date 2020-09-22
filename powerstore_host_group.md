Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## Host_group



```puppet
powerstore_host_group {
  add_host_ids => "add_host_ids (optional)",
  description => "description (optional)",
  host_ids => "host_ids",
  id => "id",
  name => "name (optional)",
  remove_host_ids => "remove_host_ids (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|add_host_ids | Array | false |
|description | String | false |
|host_ids | Array | true |
|id | String | true |
|name | String | false |
|remove_host_ids | Array | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the host_group

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/host_group`|Post|Create a host group.|host_groupCreate|
|List - list all|`/host_group`|Get|List host groups.|host_groupCollectionQuery|
|List - get one|`/host_group/%{id}`|Get|Get details about a specific host group.|host_groupInstanceQuery|
|List - get list using params|``||||
|Update|`/host_group/%{id}`|Patch|Operations that can be performed are modify name, remove host(s) from host group, add host(s) to host group. Modify request will only support either a add_host(s) or remove_host(s) at a time along with modifying host name|host_groupModify|
|Delete|`/host_group/%{id}`|Delete|Delete a host group. Delete fails if host group is attached to a volume.|host_groupDelete|
