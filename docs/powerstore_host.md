Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## Host

Manage hosts that access the cluster.

```puppet
powerstore_host {
  add_initiators => "add_initiators (optional)",
  description => "description (optional)",
  initiators => "initiators",
  modify_initiators => "modify_initiators (optional)",
  name => "name",
  os_type => "os_type",
  remove_initiators => "remove_initiators (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|add_initiators | Optional[Array[Struct[{Optional[chap_mutual_password] => String[12,64], Optional[chap_mutual_username] => String[1,64], Optional[chap_single_password] => String[12,64], Optional[chap_single_username] => String[1,64], port_name => String, port_type => Enum['iSCSI','FC'], }]]] | false |
|description | Optional[String[1,256]] | false |
|initiators | Array[Struct[{Optional[chap_mutual_password] => String[12,64], Optional[chap_mutual_username] => String[1,64], Optional[chap_single_password] => String[12,64], Optional[chap_single_username] => String[1,64], port_name => String, port_type => Enum['iSCSI','FC'], }]] | true |
|modify_initiators | Optional[Array[Struct[{Optional[chap_mutual_password] => String[12,64], Optional[chap_mutual_username] => String[1,64], Optional[chap_single_password] => String[12,64], Optional[chap_single_username] => String[1,64], Optional[port_name] => String, }]]] | false |
|name | String[1,128] | true |
|os_type | Enum['Windows','Linux','ESXi','AIX','HP-UX','Solaris'] | true |
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
