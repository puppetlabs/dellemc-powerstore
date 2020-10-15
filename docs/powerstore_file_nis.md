Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## File_nis



```puppet
powerstore_file_nis {
  add_ip_addresses => "add_ip_addresses (optional)",
  domain => "domain (optional)",
  id => "id",
  ip_addresses => "ip_addresses (optional)",
  nas_server_id => "nas_server_id (optional)",
  remove_ip_addresses => "remove_ip_addresses (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|add_ip_addresses | Array[String] | false |
|domain | String[1,255] | false |
|id | String | true |
|ip_addresses | Array[String] | false |
|nas_server_id | String | false |
|remove_ip_addresses | Array[String] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the file_nis

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/file_nis`|Post|Create a new NIS Service on a NAS Server. Only one NIS Setting object can be created per NAS Server.|file_nis_create|
|List - list all|`/file_nis`|Get|Query the NIS settings of NAS Servers.|file_nis_collection_query|
|List - get one|`/file_nis/%{id}`|Get|Query a specific NIS settings object of a NAS Server.|file_nis_instance_query|
|List - get list using params|``||||
|Update|`/file_nis/%{id}`|Patch|Modify the NIS settings of a NAS Server.|file_nis_modify|
|Delete|`/file_nis/%{id}`|Delete|Delete NIS settings of a NAS Server.|file_nis_delete|
