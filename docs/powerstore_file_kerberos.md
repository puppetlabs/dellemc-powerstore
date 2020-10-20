Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## File_kerberos

Use these resources to manage the Kerberos service for a NAS server. One Kerberos service object may be configured per NAS Server. Kerberos is a distributed authentication service designed to provide strong authentication with secret-key cryptography. It works on the basis of "tickets" that allow nodes communicating over a non-secure network to prove their identity in a secure manner. When configured to act as a secure NFS server, the NAS Server uses the RPCSEC_GSS security framework and Kerberos authentication protocol to verify users and services. You can configure a secure NFS environment for a multiprotocol NAS Server or one that supports Unix-only shares. In this environment, user access to NFS file systems is granted based on Kerberos principal names.

```puppet
powerstore_file_kerberos {
  add_kdc_addresses => "add_kdc_addresses (optional)",
  kdc_addresses => "kdc_addresses",
  nas_server_id => "nas_server_id",
  port_number => "port_number (optional)",
  realm => "realm",
  remove_kdc_addresses => "remove_kdc_addresses (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|add_kdc_addresses | Optional[Array[String[1,255]]] | false |
|kdc_addresses | Array[String[1,255]] | true |
|nas_server_id | String | true |
|port_number | Optional[Integer[0,65535]] | false |
|realm | String[1,255] | true |
|remove_kdc_addresses | Optional[Array[String[1,255]]] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the file_kerberos

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/file_kerberos`|Post|Create a Kerberos configuration. The operation will fail if a Kerberos configuration already exists.|file_kerberos_create|
|List - list all|`/file_kerberos`|Get|Query of the Kerberos service settings of NAS Servers.|file_kerberos_collection_query|
|List - get one|`/file_kerberos/%{id}`|Get|Query a specific Kerberos service settings of a NAS Server.|file_kerberos_instance_query|
|List - get list using params|``||||
|Update|`/file_kerberos/%{id}`|Patch|Modify the Kerberos service settings of a NAS Server.|file_kerberos_modify|
|Delete|`/file_kerberos/%{id}`|Delete|Delete Kerberos configuration of a NAS Server.|file_kerberos_delete|
