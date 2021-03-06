Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## File_interface

Information about File network interfaces in the storage system. These interfaces control access to Windows (CIFS) and UNIX/Linux (NFS) file storage.

```puppet
powerstore_file_interface {
  gateway => "gateway (optional)",
  ip_address => "ip_address (optional)",
  is_disabled => "is_disabled (optional)",
  nas_server_id => "nas_server_id (optional)",
  prefix_length => "prefix_length (optional)",
  role => "role (optional)",
  vlan_id => "vlan_id (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|gateway | Optional[String[1,45]] | false |
|ip_address | Optional[String[1,45]] | false |
|is_disabled | Optional[Boolean] | false |
|nas_server_id | Optional[String] | false |
|prefix_length | Optional[Integer[1,128]] | false |
|role | Optional[Enum['Production','Backup']] | false |
|vlan_id | Optional[Integer[0,4094]] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the file_interface

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/file_interface`|Post|Create a file interface.|file_interface_create|
|List - list all|`/file_interface`|Get|Query file interfaces.|file_interface_collection_query|
|List - get one|`/file_interface/%{id}`|Get||file_interface_instance_query|
|List - get list using params|``||||
|Update|`/file_interface/%{id}`|Patch|Modify the settings of a file interface.|file_interface_modify|
|Delete|`/file_interface/%{id}`|Delete|Delete a file interface.|file_interface_delete|
