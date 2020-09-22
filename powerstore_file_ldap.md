Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## File_ldap



```puppet
powerstore_file_ldap {
  add_addresses => "add_addresses (optional)",
  addresses => "addresses (optional)",
  authentication_type => "authentication_type (optional)",
  base_dn => "base_dn (optional)",
  bind_dn => "bind_dn (optional)",
  bind_password => "bind_password (optional)",
  id => "id",
  is_smb_account_used => "is_smb_account_used (optional)",
  is_verify_server_certificate => "is_verify_server_certificate (optional)",
  nas_server_id => "nas_server_id",
  password => "password (optional)",
  port_number => "1234 (optional)",
  principal => "principal (optional)",
  profile_dn => "profile_dn (optional)",
  protocol => "protocol (optional)",
  realm => "realm (optional)",
  remove_addresses => "remove_addresses (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|add_addresses | Array | false |
|addresses | Array | false |
|authentication_type | String | false |
|base_dn | String | false |
|bind_dn | String | false |
|bind_password | String | false |
|id | String | true |
|is_smb_account_used | Boolean | false |
|is_verify_server_certificate | Boolean | false |
|nas_server_id | String | true |
|password | String | false |
|port_number | Integer | false |
|principal | String | false |
|profile_dn | String | false |
|protocol | String | false |
|realm | String | false |
|remove_addresses | Array | false |



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
