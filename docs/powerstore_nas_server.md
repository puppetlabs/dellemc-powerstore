Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## Nas_server

Use these resource types to manage NAS servers. NAS servers are software components used to transfer data and provide the connection ports for hosts to access file-based storage resources. NAS servers are independent from each other.

```puppet
powerstore_nas_server {
  backup_i_pv4_interface_id => "backup_IPv4_interface_id (optional)",
  backup_i_pv6_interface_id => "backup_IPv6_interface_id (optional)",
  current_node_id => "current_node_id (optional)",
  current_unix_directory_service => "current_unix_directory_service (optional)",
  default_unix_user => "default_unix_user (optional)",
  default_windows_user => "default_windows_user (optional)",
  description => "description (optional)",
  domain_password => "domain_password (optional)",
  domain_user_name => "domain_user_name (optional)",
  is_auto_user_mapping_enabled => "is_auto_user_mapping_enabled (optional)",
  is_skip_domain_unjoin => "is_skip_domain_unjoin (optional)",
  is_username_translation_enabled => "is_username_translation_enabled (optional)",
  name => "name",
  preferred_node_id => "preferred_node_id (optional)",
  production_i_pv4_interface_id => "production_IPv4_interface_id (optional)",
  production_i_pv6_interface_id => "production_IPv6_interface_id (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|backup_i_pv4_interface_id | Optional[String] | false |
|backup_i_pv6_interface_id | Optional[String] | false |
|current_node_id | Optional[String] | false |
|current_unix_directory_service | Optional[Enum['None','NIS','LDAP','Local_Files','Local_Then_NIS','Local_Then_LDAP']] | false |
|default_unix_user | Optional[String[0,63]] | false |
|default_windows_user | Optional[String[0,1023]] | false |
|description | Optional[String[0,255]] | false |
|domain_password | Optional[String] | false |
|domain_user_name | Optional[String] | false |
|is_auto_user_mapping_enabled | Optional[Boolean] | false |
|is_skip_domain_unjoin | Optional[Boolean] | false |
|is_username_translation_enabled | Optional[Boolean] | false |
|name | String[1,255] | true |
|preferred_node_id | Optional[String] | false |
|production_i_pv4_interface_id | Optional[String] | false |
|production_i_pv6_interface_id | Optional[String] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the nas_server

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/nas_server`|Post|Create a NAS server.|nas_server_create|
|List - list all|`/nas_server`|Get|Query all NAS servers.|nas_server_collection_query|
|List - get one|`/nas_server/%{id}`|Get|Query a specific NAS server.|nas_server_instance_query|
|List - get list using params|``||||
|Update|`/nas_server/%{id}`|Patch|Modify the settings of a NAS server.|nas_server_modify|
|Delete|`/nas_server/%{id}`|Delete|Delete a NAS server.|nas_server_delete|
