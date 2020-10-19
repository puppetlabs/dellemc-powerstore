Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## File_dns



```puppet
powerstore_file_dns {
  add_ip_addresses => "add_ip_addresses (optional)",
  domain => "domain",
  id => "id",
  ip_addresses => "ip_addresses",
  nas_server_id => "nas_server_id",
  remove_ip_addresses => "remove_ip_addresses (optional)",
  transport => "transport (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|add_ip_addresses | Optional[Array[String]] | false |
|domain | String[1,255] | true |
|id | String | true |
|ip_addresses | Array[String] | true |
|nas_server_id | String | true |
|remove_ip_addresses | Optional[Array[String]] | false |
|transport | Optional[Enum['UDP','TCP']] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the file_dns

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/file_dns`|Post|Create a new DNS Server configuration for a NAS Server. Only one object can be created per NAS Server.|file_dns_create|
|List - list all|`/file_dns`|Get|Query of the DNS settings of NAS Servers.|file_dns_collection_query|
|List - get one|`/file_dns/%{id}`|Get|Query a specific DNS settings object of a NAS Server.|file_dns_instance_query|
|List - get list using params|``||||
|Update|`/file_dns/%{id}`|Patch|Modify the DNS settings of a NAS Server.|file_dns_modify|
|Delete|`/file_dns/%{id}`|Delete|Delete DNS settings of a NAS Server.|file_dns_delete|