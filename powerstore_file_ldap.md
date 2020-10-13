Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## File_ldap



```puppet
powerstore_file_ldap {
  add_addresses => "add_addresses (optional)",
  addresses => "addresses (optional)",
  authentication_type => "authentication_type (optional)",
  base_dn => "base_DN (optional)",
  bind_dn => "bind_DN (optional)",
  bind_password => "bind_password (optional)",
  id => "id",
  is_smb_account_used => "is_smb_account_used (optional)",
  is_verify_server_certificate => "is_verify_server_certificate (optional)",
  nas_server_id => "nas_server_id (optional)",
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
|add_addresses | Array[String] | false |
|addresses | Array[String] | false |
|authentication_type | Enum['Anonymous','Simple','Kerberos'] | false |
|base_dn | String[3,255] | false |
|bind_dn | String[0,1023] | false |
|bind_password | String[0,1023] | false |
|id | String | true |
|is_smb_account_used | Boolean | false |
|is_verify_server_certificate | Boolean | false |
|nas_server_id | String | false |
|password | String[0,1023] | false |
|port_number | Integer[0,65536] | false |
|principal | String[0,1023] | false |
|profile_dn | String[0,255] | false |
|protocol | Enum['LDAP','LDAPS'] | false |
|realm | String[0,255] | false |
|remove_addresses | Array[String] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the file_ldap

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/file_ldap`|Post|Create an LDAP service on a NAS Server. Only one LDAP Service object can be created per NAS Server.|file_ldapCreate|
|List - list all|`/file_ldap`|Get|List LDAP Service instances.|file_ldapCollectionQuery|
|List - get one|`/file_ldap/%{id}`|Get|Query a specific NAS Server's LDAP settings object.|file_ldapInstanceQuery|
|List - get list using params|``||||
|Update|`/file_ldap/%{id}`|Patch|Modify a NAS Server's LDAP settings object.|file_ldapModify|
|Delete|`/file_ldap/%{id}`|Delete|Delete a NAS Server's LDAP settings.|file_ldapDelete|
