Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## Nfs_server



```puppet
powerstore_nfs_server {
  credentials_cache_ttl => "1234 (optional)",
  host_name => "host_name (optional)",
  id => "id",
  is_extended_credentials_enabled => "is_extended_credentials_enabled (optional)",
  is_nfsv3_enabled => "is_nfsv3_enabled (optional)",
  is_nfsv4_enabled => "is_nfsv4_enabled (optional)",
  is_secure_enabled => "is_secure_enabled (optional)",
  is_skip_unjoin => "is_skip_unjoin (optional)",
  is_use_smb_config_enabled => "is_use_smb_config_enabled (optional)",
  nas_server_id => "nas_server_id",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|credentials_cache_ttl | Integer | false |
|host_name | String | false |
|id | String | true |
|is_extended_credentials_enabled | Boolean | false |
|is_nfsv3_enabled | Boolean | false |
|is_nfsv4_enabled | Boolean | false |
|is_secure_enabled | Boolean | false |
|is_skip_unjoin | Boolean | false |
|is_use_smb_config_enabled | Boolean | false |
|nas_server_id | String | true |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the nfs_server

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/nfs_server`|Post|Create an NFS server.|nfs_serverCreate|
|List - list all|`/nfs_server`|Get|Query all NFS Servers.|nfs_serverCollectionQuery|
|List - get one|`/nfs_server/%{id}`|Get|Query settings of an NFS server.|nfs_serverInstanceQuery|
|List - get list using params|``||||
|Update|`/nfs_server/%{id}`|Patch|Modify NFS server settings.|nfs_serverModify|
|Delete|`/nfs_server/%{id}`|Delete|Delete an NFS server.|nfs_serverDelete|
