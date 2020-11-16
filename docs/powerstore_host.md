Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## Host

Manage hosts that access the cluster.

```puppet
powerstore_host {
  add_initiators => "add_initiators (optional)",
  description => "description (optional)",
  initiators => "initiators (optional)",
  modify_initiators => "modify_initiators (optional)",
  name => "name",
  os_type => "os_type (optional)",
  remove_initiators => "remove_initiators (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|add_initiators | Optional[Array[Struct[{Optional[chap_mutual_password] => Optional[String[12,64]], Optional[chap_mutual_username] => Optional[String[1,64]], Optional[chap_single_password] => Optional[String[12,64]], Optional[chap_single_username] => Optional[String[1,64]], port_name => Optional[String], port_type => Optional[Enum['iSCSI','FC']], }]]] | false |
|description | Optional[String[0,256]] | false |
|initiators | Optional[Array[Struct[{Optional[chap_mutual_password] => Optional[String[12,64]], Optional[chap_mutual_username] => Optional[String[1,64]], Optional[chap_single_password] => Optional[String[12,64]], Optional[chap_single_username] => Optional[String[1,64]], port_name => Optional[String], port_type => Optional[Enum['iSCSI','FC']], }]]] | false |
|modify_initiators | Optional[Array[Struct[{Optional[chap_mutual_password] => Optional[String[12,64]], Optional[chap_mutual_username] => Optional[String[1,64]], Optional[chap_single_password] => Optional[String[12,64]], Optional[chap_single_username] => Optional[String[1,64]], Optional[port_name] => Optional[String], }]]] | false |
|name | String[0,128] | true |
|os_type | Optional[Enum['Windows','Linux','ESXi','AIX','HP-UX','Solaris']] | false |
|remove_initiators | Optional[Array[String]] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the host

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/host`|Post|Add a host.|host_create|
|List - list all|`/host`|Get|List host information.|host_collection_query|
|List - get one|`/host/%{id}`|Get|Get details about a specific host by id.|host_instance_query|
|List - get list using params|``||||
|Update|`/host/%{id}`|Patch|Operation that can be performed are modify name, modify description, remove initiator(s) from host, add initiator(s) to host, update existing initiator(s) with chap username/password. This will only support one of add, remove and update initiator operations in a single request.|host_modify|
|Delete|`/host/%{id}`|Delete|Delete a host. Delete fails if host is attached to a volume or consistency group.|host_delete|
