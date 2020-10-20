Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## Smb_share

SMB Shares use the SMB protocol to provide an access point for configured Windows hosts to access file system storage. The system uses Active Directory to authenticate user and user group access to the Share.

```puppet
powerstore_smb_share {
  description => "description (optional)",
  file_system_id => "file_system_id (optional)",
  is_abe_enabled => "is_ABE_enabled (optional)",
  is_branch_cache_enabled => "is_branch_cache_enabled (optional)",
  is_continuous_availability_enabled => "is_continuous_availability_enabled (optional)",
  is_encryption_enabled => "is_encryption_enabled (optional)",
  name => "name",
  offline_availability => "offline_availability (optional)",
  path => "path (optional)",
  umask => "umask (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|description | Optional[String[0,511]] | false |
|file_system_id | Optional[String] | false |
|is_abe_enabled | Optional[Boolean] | false |
|is_branch_cache_enabled | Optional[Boolean] | false |
|is_continuous_availability_enabled | Optional[Boolean] | false |
|is_encryption_enabled | Optional[Boolean] | false |
|name | String[1,80] | true |
|offline_availability | Optional[Enum['Manual','Documents','Programs','None']] | false |
|path | Optional[String] | false |
|umask | Optional[String] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the smb_share

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/smb_share`|Post|Create an SMB share.|smb_share_create|
|List - list all|`/smb_share`|Get|List SMB shares.|smb_share_collection_query|
|List - get one|`/smb_share/%{id}`|Get|Get an SMB Share.|smb_share_instance_query|
|List - get list using params|``||||
|Update|`/smb_share/%{id}`|Patch|Modify SMB share properties.|smb_share_modify|
|Delete|`/smb_share/%{id}`|Delete|Delete an SMB Share.|smb_share_delete|
