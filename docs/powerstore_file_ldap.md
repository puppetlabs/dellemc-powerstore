Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## File_ldap

Use these resources to manage the Lightweight Directory Access Protocol (LDAP) settings for the NAS Server. You can configure one LDAP settings object per NAS Server. LDAP is an application protocol for querying and modifying directory services running on TCP/IP networks. LDAP provides central management for network authentication and authorization operations by helping to centralize user and group management across the network. A NAS Server can use LDAP as a Unix Directory Service to map users, retrieve netgroups, and build a Unix credential. When an initial LDAP configuration is applied, the system checks for the type of LDAP server. It can be an Active Directory schema or an RFC 2307 schema.

```puppet
powerstore_file_ldap {
  add_addresses => "add_addresses (optional)",
  addresses => "addresses (optional)",
  authentication_type => "authentication_type",
  base_dn => "base_DN",
  bind_dn => "bind_DN (optional)",
  bind_password => "bind_password (optional)",
  is_smb_account_used => "is_smb_account_used (optional)",
  is_verify_server_certificate => "is_verify_server_certificate (optional)",
  nas_server_id => "nas_server_id",
  password => "password (optional)",
  port_number => "port_number (optional)",
  principal => "principal (optional)",
  profile_dn => "profile_DN (optional)",
  protocol => "protocol (optional)",
  realm => "realm (optional)",
  remove_addresses => "remove_addresses (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|add_addresses | Optional[Array[String]] | false |
|addresses | Optional[Array[String]] | false |
|authentication_type | Enum['Anonymous','Simple','Kerberos'] | true |
|base_dn | String[3,255] | true |
|bind_dn | Optional[String[0,1023]] | false |
|bind_password | Optional[String[0,1023]] | false |
|is_smb_account_used | Optional[Boolean] | false |
|is_verify_server_certificate | Optional[Boolean] | false |
|nas_server_id | String | true |
|password | Optional[String[0,1023]] | false |
|port_number | Optional[Integer[0,65536]] | false |
|principal | Optional[String[0,1023]] | false |
|profile_dn | Optional[String[0,255]] | false |
|protocol | Optional[Enum['LDAP','LDAPS']] | false |
|realm | Optional[String[0,255]] | false |
|remove_addresses | Optional[Array[String]] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the file_ldap

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/file_ldap`|Post|Create an LDAP service on a NAS Server. Only one LDAP Service object can be created per NAS Server.|file_ldap_create|
|List - list all|`/file_ldap`|Get|List LDAP Service instances.|file_ldap_collection_query|
|List - get one|`/file_ldap/%{id}`|Get|Query a specific NAS Server's LDAP settings object.|file_ldap_instance_query|
|List - get list using params|``||||
|Update|`/file_ldap/%{id}`|Patch|Modify a NAS Server's LDAP settings object.|file_ldap_modify|
|Delete|`/file_ldap/%{id}`|Delete|Delete a NAS Server's LDAP settings.|file_ldap_delete|
