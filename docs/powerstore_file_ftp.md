Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## File_ftp

Use these resources to configure one File Transfer Protocol (FTP) server per NAS server. One FTP server can be configured per NAS server to have both secure and unsecure services running. By default when an FTP server is created, the unsecure service will be running. FTP is a standard network protocol used to transfer files from one host to another host over a TCP-based network, such as the Internet. For secure transmission that encrypts the username, password, and content, FTP is secured with SSH (SFTP). SFTP listens on port 22.
You can activate an FTP server and SFTP server independently on each NAS server. The FTP and SFTP clients are authenticated using credentials defined on a Unix name server (such as an NIS server or an LDAP server) or a Windows domain. Windows user names need to be entered using the 'username@domain' or 'domain\\username' formats. Each secure and unsecure service must have a home directory defined in the name server that must be accessible on the NAS server. FTP also allows clients to connect as anonymous users.  


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
  nas_server_id => "nas_server_id",
  remove_groups => "remove_groups (optional)",
  remove_hosts => "remove_hosts (optional)",
  remove_users => "remove_users (optional)",
  users => "users (optional)",
  welcome_message => "welcome_message (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|add_groups | Optional[Array[String]] | false |
|add_hosts | Optional[Array[String]] | false |
|add_users | Optional[Array[String]] | false |
|audit_dir | Optional[String] | false |
|audit_max_size | Optional[Integer[40960,9223372036854775807]] | false |
|default_homedir | Optional[String] | false |
|groups | Optional[Array[String]] | false |
|hosts | Optional[Array[String]] | false |
|is_allowed_groups | Optional[Boolean] | false |
|is_allowed_hosts | Optional[Boolean] | false |
|is_allowed_users | Optional[Boolean] | false |
|is_anonymous_authentication_enabled | Optional[Boolean] | false |
|is_audit_enabled | Optional[Boolean] | false |
|is_ftp_enabled | Optional[Boolean] | false |
|is_homedir_limit_enabled | Optional[Boolean] | false |
|is_sftp_enabled | Optional[Boolean] | false |
|is_smb_authentication_enabled | Optional[Boolean] | false |
|is_unix_authentication_enabled | Optional[Boolean] | false |
|message_of_the_day | Optional[String] | false |
|nas_server_id | String | true |
|remove_groups | Optional[Array[String]] | false |
|remove_hosts | Optional[Array[String]] | false |
|remove_users | Optional[Array[String]] | false |
|users | Optional[Array[String]] | false |
|welcome_message | Optional[String] | false |



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
