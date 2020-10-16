Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

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
|add_no_access_hosts | Optional[Array[String]] | false |
|add_read_only_hosts | Optional[Array[String]] | false |
|add_read_only_root_hosts | Optional[Array[String]] | false |
|add_read_write_hosts | Optional[Array[String]] | false |
|add_read_write_root_hosts | Optional[Array[String]] | false |
|anonymous_gid | Optional[Integer[-2147483648,2147483647]] | false |
|anonymous_uid | Optional[Integer[-2147483648,2147483647]] | false |
|default_access | Optional[Enum['No_Access','Read_Only','Read_Write','Root','Read_Only_Root']] | false |
|description | Optional[String[0,511]] | false |
|file_system_id | String | true |
|id | String | true |
|is_no_suid | Optional[Boolean] | false |
|min_security | Optional[Enum['Sys','Kerberos','Kerberos_With_Integrity','Kerberos_With_Encryption']] | false |
|name | String[1,80] | true |
|no_access_hosts | Optional[Array[String]] | false |
|path | String[1,1023] | true |
|read_only_hosts | Optional[Array[String]] | false |
|read_only_root_hosts | Optional[Array[String]] | false |
|read_write_hosts | Optional[Array[String]] | false |
|read_write_root_hosts | Optional[Array[String]] | false |
|remove_no_access_hosts | Optional[Array[String]] | false |
|remove_read_only_hosts | Optional[Array[String]] | false |
|remove_read_only_root_hosts | Optional[Array[String]] | false |
|remove_read_write_hosts | Optional[Array[String]] | false |
|remove_read_write_root_hosts | Optional[Array[String]] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the nfs_export

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/nfs_export`|Post|Create an NFS Export for a Snapshot.|nfs_export_create|
|List - list all|`/nfs_export`|Get|List NFS Exports.|nfs_export_collection_query|
|List - get one|`/nfs_export/%{id}`|Get|Get NFS Export properties.|nfs_export_instance_query|
|List - get list using params|``||||
|Update|`/nfs_export/%{id}`|Patch|Modify NFS Export Properties.|nfs_export_modify|
|Delete|`/nfs_export/%{id}`|Delete|Delete NFS Export.|nfs_export_delete|
