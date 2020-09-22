Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## File_interface



```puppet
powerstore_file_interface {
  gateway => "gateway (optional)",
  id => "id",
  ip_address => "ip_address (optional)",
  is_disabled => "is_disabled (optional)",
  nas_server_id => "nas_server_id",
  prefix_length => "1234 (optional)",
  role => "role (optional)",
  vlan_id => "1234 (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|gateway | String | false |
|id | String | true |
|ip_address | String | false |
|is_disabled | Boolean | false |
|nas_server_id | String | true |
|prefix_length | Integer | false |
|role | String | false |
|vlan_id | Integer | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the file_interface

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/file_interface`|Post|Create a file interface.|file_interfaceCreate|
|List - list all|`/file_interface`|Get|Query file interfaces.|file_interfaceCollectionQuery|
|List - get one|`/file_interface/%{id}`|Get||file_interfaceInstanceQuery|
|List - get list using params|``||||
|Update|`/file_interface/%{id}`|Patch|Modify the settings of a file interface.|file_interfaceModify|
|Delete|`/file_interface/%{id}`|Delete|Delete a file interface.|file_interfaceDelete|
