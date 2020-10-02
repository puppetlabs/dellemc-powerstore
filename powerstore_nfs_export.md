Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## Nfs_export



```puppet
powerstore_nfs_export {
  add_no_access_hosts => "add_no_access_hosts (optional)",
  add_read_only_hosts => "add_read_only_hosts (optional)",
  add_read_only_root_hosts => "add_read_only_root_hosts (optional)",
  add_read_write_hosts => "add_read_write_hosts (optional)",
  add_read_write_root_hosts => "add_read_write_root_hosts (optional)",
  anonymous_gid => "anonymous_GID (optional)",
  anonymous_uid => "anonymous_UID (optional)",
  default_access => "default_access (optional)",
  description => "description (optional)",
  file_system_id => "file_system_id",
  id => "id",
  is_no_suid => "is_no_SUID (optional)",
  min_security => "min_security (optional)",
  name => "name",
  no_access_hosts => "no_access_hosts (optional)",
  path => "path",
  read_only_hosts => "read_only_hosts (optional)",
  read_only_root_hosts => "read_only_root_hosts (optional)",
  read_write_hosts => "read_write_hosts (optional)",
  read_write_root_hosts => "read_write_root_hosts (optional)",
  remove_no_access_hosts => "remove_no_access_hosts (optional)",
  remove_read_only_hosts => "remove_read_only_hosts (optional)",
  remove_read_only_root_hosts => "remove_read_only_root_hosts (optional)",
  remove_read_write_hosts => "remove_read_write_hosts (optional)",
  remove_read_write_root_hosts => "remove_read_write_root_hosts (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|add_no_access_hosts | Array | false |
|add_read_only_hosts | Array | false |
|add_read_only_root_hosts | Array | false |
|add_read_write_hosts | Array | false |
|add_read_write_root_hosts | Array | false |
|anonymous_gid | Integer[18446744071562067968, 2147483647] | false |
|anonymous_uid | Integer[18446744071562067968, 2147483647] | false |
|default_access | Enum['No_Access','Read_Only','Read_Write','Root','Read_Only_Root'] | false |
|description | String[0,511] | false |
|file_system_id | String | true |
|id | String | true |
|is_no_suid | Boolean | false |
|min_security | Enum['Sys','Kerberos','Kerberos_With_Integrity','Kerberos_With_Encryption'] | false |
|name | String[0,80] | true |
|no_access_hosts | Array | false |
|path | String[0,1023] | true |
|read_only_hosts | Array | false |
|read_only_root_hosts | Array | false |
|read_write_hosts | Array | false |
|read_write_root_hosts | Array | false |
|remove_no_access_hosts | Array | false |
|remove_read_only_hosts | Array | false |
|remove_read_only_root_hosts | Array | false |
|remove_read_write_hosts | Array | false |
|remove_read_write_root_hosts | Array | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the nfs_export

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/nfs_export`|Post|Create an NFS Export for a Snapshot.|nfs_exportCreate|
|List - list all|`/nfs_export`|Get|List NFS Exports.|nfs_exportCollectionQuery|
|List - get one|`/nfs_export/%{id}`|Get|Get NFS Export properties.|nfs_exportInstanceQuery|
|List - get list using params|``||||
|Update|`/nfs_export/%{id}`|Patch|Modify NFS Export Properties.|nfs_exportModify|
|Delete|`/nfs_export/%{id}`|Delete|Delete NFS Export.|nfs_exportDelete|
