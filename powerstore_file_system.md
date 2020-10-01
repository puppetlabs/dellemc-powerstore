Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## File_system



```puppet
powerstore_file_system {
  access_policy => "access_policy (optional)",
  default_hard_limit => "default_hard_limit (optional)",
  default_soft_limit => "default_soft_limit (optional)",
  description => "description (optional)",
  expiration_timestamp => "expiration_timestamp (optional)",
  folder_rename_policy => "folder_rename_policy (optional)",
  grace_period => "grace_period (optional)",
  id => "id",
  is_async_m_time_enabled => "is_async_MTime_enabled (optional)",
  is_quota_enabled => "is_quota_enabled (optional)",
  is_smb_no_notify_enabled => "is_smb_no_notify_enabled (optional)",
  is_smb_notify_on_access_enabled => "is_smb_notify_on_access_enabled (optional)",
  is_smb_notify_on_write_enabled => "is_smb_notify_on_write_enabled (optional)",
  is_smb_op_locks_enabled => "is_smb_op_locks_enabled (optional)",
  is_smb_sync_writes_enabled => "is_smb_sync_writes_enabled (optional)",
  locking_policy => "locking_policy (optional)",
  name => "name",
  nas_server_id => "nas_server_id",
  protection_policy_id => "protection_policy_id (optional)",
  size_total => "size_total (optional)",
  smb_notify_on_change_dir_depth => "smb_notify_on_change_dir_depth (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|access_policy | String | false |
|default_hard_limit | Integer[0, 9223372036854775808] | false |
|default_soft_limit | Integer[0, 9223372036854775808] | false |
|description | String[0,255] | false |
|expiration_timestamp | String | false |
|folder_rename_policy | String | false |
|grace_period | Integer[18446744073709551615, 2147483647] | false |
|id | String | true |
|is_async_m_time_enabled | Boolean | false |
|is_quota_enabled | Boolean | false |
|is_smb_no_notify_enabled | Boolean | false |
|is_smb_notify_on_access_enabled | Boolean | false |
|is_smb_notify_on_write_enabled | Boolean | false |
|is_smb_op_locks_enabled | Boolean | false |
|is_smb_sync_writes_enabled | Boolean | false |
|locking_policy | String | false |
|name | String[0,255] | true |
|nas_server_id | String | true |
|protection_policy_id | String | false |
|size_total | Integer[3221225472, 281474976710656] | false |
|smb_notify_on_change_dir_depth | Integer[1, 512] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the file_system

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/file_system`|Post|Create a file system.|file_systemCreate|
|List - list all|`/file_system`|Get|List file systems.|file_systemCollectionQuery|
|List - get one|`/file_system/%{id}`|Get|Query a specific file system.|file_systemInstanceQuery|
|List - get list using params|``||||
|Update|`/file_system/%{id}`|Patch|Modify a file system.|file_systemModify|
|Delete|`/file_system/%{id}`|Delete|Delete a file system.|file_systemDelete|
