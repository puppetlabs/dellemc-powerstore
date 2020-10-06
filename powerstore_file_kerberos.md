Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## File_kerberos



```puppet
powerstore_file_kerberos {
  add_kdc_addresses => "add_kdc_addresses (optional)",
  id => "id",
  kdc_addresses => "kdc_addresses",
  nas_server_id => "nas_server_id",
  port_number => "port_number (optional)",
  realm => "realm",
  remove_kdc_addresses => "remove_kdc_addresses (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|add_kdc_addresses | Array[String[1,255]] | false |
|id | String | true |
|kdc_addresses | Array[String[1,255]] | true |
|nas_server_id | String | true |
|port_number | Integer[0,65535] | false |
|realm | String[1,255] | true |
|remove_kdc_addresses | Array[String[1,255]] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the file_kerberos

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/file_kerberos`|Post|Create a Kerberos configuration. The operation will fail if a Kerberos configuration already exists.|file_kerberosCreate|
|List - list all|`/file_kerberos`|Get|Query of the Kerberos service settings of NAS Servers.|file_kerberosCollectionQuery|
|List - get one|`/file_kerberos/%{id}`|Get|Query a specific Kerberos service settings of a NAS Server.|file_kerberosInstanceQuery|
|List - get list using params|``||||
|Update|`/file_kerberos/%{id}`|Patch|Modify the Kerberos service settings of a NAS Server.|file_kerberosModify|
|Delete|`/file_kerberos/%{id}`|Delete|Delete Kerberos configuration of a NAS Server.|file_kerberosDelete|
