Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## File_ftp



```puppet
powerstore_file_ftp {
  add_groups => "add_groups (optional)",
  add_hosts => "add_hosts (optional)",
  add_users => "add_users (optional)",
  audit_dir => "audit_dir (optional)",
  audit_max_size => "audit_max_size (optional)",
  default_homedir => "default_homedir (optional)",
  groups => "groups (optional)",
  hosts => "hosts (optional)",
  id => "id",
  is_allowed_groups => "is_allowed_groups (optional)",
  is_allowed_hosts => "is_allowed_hosts (optional)",
  is_allowed_users => "is_allowed_users (optional)",
  is_anonymous_authentication_enabled => "is_anonymous_authentication_enabled (optional)",
  is_audit_enabled => "is_audit_enabled (optional)",
  is_ftp_enabled => "is_ftp_enabled (optional)",
  is_homedir_limit_enabled => "is_homedir_limit_enabled (optional)",
  is_sftp_enabled => "is_sftp_enabled (optional)",
  is_smb_authentication_enabled => "is_smb_authentication_enabled (optional)",
  is_unix_authentication_enabled => "is_unix_authentication_enabled (optional)",
  message_of_the_day => "message_of_the_day (optional)",
  nas_server_id => "nas_server_id (optional)",
  remove_groups => "remove_groups (optional)",
  remove_hosts => "remove_hosts (optional)",
  remove_users => "remove_users (optional)",
  users => "users (optional)",
  welcome_message => "welcome_message (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|add_groups | Array[String] | false |
|add_hosts | Array[String] | false |
|add_users | Array[String] | false |
|audit_dir | String | false |
|audit_max_size | Integer[40960,9223372036854775807] | false |
|default_homedir | String | false |
|groups | Array[String] | false |
|hosts | Array[String] | false |
|id | String | true |
|is_allowed_groups | Boolean | false |
|is_allowed_hosts | Boolean | false |
|is_allowed_users | Boolean | false |
|is_anonymous_authentication_enabled | Boolean | false |
|is_audit_enabled | Boolean | false |
|is_ftp_enabled | Boolean | false |
|is_homedir_limit_enabled | Boolean | false |
|is_sftp_enabled | Boolean | false |
|is_smb_authentication_enabled | Boolean | false |
|is_unix_authentication_enabled | Boolean | false |
|message_of_the_day | String | false |
|nas_server_id | String | false |
|remove_groups | Array[String] | false |
|remove_hosts | Array[String] | false |
|remove_users | Array[String] | false |
|users | Array[String] | false |
|welcome_message | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the file_ftp

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/file_ftp`|Post|Create an FTP/SFTP server.|file_ftp_create|
|List - list all|`/file_ftp`|Get|Query FTP/SFTP instances.|file_ftp_collection_query|
|List - get one|`/file_ftp/%{id}`|Get|Query a specific FTP/SFTP server for its settings.|file_ftp_instance_query|
|List - get list using params|``||||
|Update|`/file_ftp/%{id}`|Patch|Modify an FTP/SFTP server settings.|file_ftp_modify|
|Delete|`/file_ftp/%{id}`|Delete|Delete an FTP/SFTP Server.|file_ftp_delete|
