Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## Smb_server



```puppet
powerstore_smb_server {
  computer_name => "computer_name (optional)",
  description => "description (optional)",
  domain => "domain (optional)",
  id => "id",
  is_standalone => "is_standalone (optional)",
  local_admin_password => "local_admin_password (optional)",
  nas_server_id => "nas_server_id",
  netbios_name => "netbios_name (optional)",
  workgroup => "workgroup (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|computer_name | String | false |
|description | String | false |
|domain | String | false |
|id | String | true |
|is_standalone | Boolean | false |
|local_admin_password | String | false |
|nas_server_id | String | true |
|netbios_name | String | false |
|workgroup | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the smb_server

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/smb_server`|Post|Create an SMB server.|smb_serverCreate|
|List - list all|`/smb_server`|Get|Query all SMB servers.|smb_serverCollectionQuery|
|List - get one|`/smb_server/%{id}`|Get|Query settings of a specific SMB server.|smb_serverInstanceQuery|
|List - get list using params|``||||
|Update|`/smb_server/%{id}`|Patch|Modify an SMB server's settings.|smb_serverModify|
|Delete|`/smb_server/%{id}`|Delete|Delete a SMB server. The SMB server must not be joined to a domain to be deleted.
|smb_serverDelete|
