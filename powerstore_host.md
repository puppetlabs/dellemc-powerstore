Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## Host



```puppet
powerstore_host {
  add_initiators => "add_initiators (optional)",
  description => "description (optional)",
  id => "id",
  initiators => "initiators",
  modify_initiators => "modify_initiators (optional)",
  name => "name (optional)",
  os_type => "os_type",
  remove_initiators => "remove_initiators (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|add_initiators | Array | false |
|description | String | false |
|id | String | true |
|initiators | Array | true |
|modify_initiators | Array | false |
|name | String | false |
|os_type | String | true |
|remove_initiators | Array | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the host

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/host`|Post|Add a host.|hostCreate|
|List - list all|`/host`|Get|List host information.|hostCollectionQuery|
|List - get one|`/host/%{id}`|Get|Get details about a specific host by id.|hostInstanceQuery|
|List - get list using params|``||||
|Update|`/host/%{id}`|Patch|Operation that can be performed are modify name, modify description, remove initiator(s) from host, add initiator(s) to host, update existing initiator(s) with chap username/password. This will only support one of add, remove and update initiator operations in a single request.|hostModify|
|Delete|`/host/%{id}`|Delete|Delete a host. Delete fails if host is attached to a volume or consistency group.|hostDelete|
