Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## File_nis

Use these resources to manage the Network Information Service (NIS) settings object for a NAS Server. One NIS settings object may be configured per NAS server. NIS consists of a directory service protocol for maintaining and distributing system configuration information, such as user and group information, hostnames, and such. The port for NIS Service is 111.

```puppet
powerstore_file_nis {
  add_ip_addresses => "add_ip_addresses (optional)",
  domain => "domain",
  ip_addresses => "ip_addresses",
  nas_server_id => "nas_server_id",
  remove_ip_addresses => "remove_ip_addresses (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|add_ip_addresses | Optional[Array[String]] | false |
|domain | String[1,255] | true |
|ip_addresses | Array[String] | true |
|nas_server_id | String | true |
|remove_ip_addresses | Optional[Array[String]] | false |



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
