Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## File_ndmp

The Network Data Management Protocol (NDMP) provides a standard for backing up file servers on a network. NDMP allows centralized applications to back up file servers that run on various platforms and platform versions. NDMP reduces network congestion by isolating control path traffic from data path traffic, which permits centrally managed and monitored local backup operations. Storage systems support NDMP v2-v4 over the network. Direct-attach NDMP is not supported. This means that the tape drives need to be connected to a media server, and the NAS server communicates with the media server over the network. NDMP has an advantage when using multiprotocol file systems because it backs up the Windows ACLs as well as the UNIX security information.

```puppet
powerstore_file_ndmp {
  nas_server_id => "nas_server_id (optional)",
  password => "password (optional)",
  user_name => "user_name (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|nas_server_id | Optional[String] | false |
|password | Optional[String] | false |
|user_name | Optional[String] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the file_ndmp

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/file_ndmp`|Post|Add an NDMP service configuration to a NAS server. Only one NDMP service object can be configured per NAS server.|file_ndmp_create|
|List - list all|`/file_ndmp`|Get|List configured NDMP service instances.|file_ndmp_collection_query|
|List - get one|`/file_ndmp/%{id}`|Get|Query an NDMP service configuration instance.|file_ndmp_instance_query|
|List - get list using params|``||||
|Update|`/file_ndmp/%{id}`|Patch|Modify an NDMP service configuration instance.|file_ndmp_modify|
|Delete|`/file_ndmp/%{id}`|Delete|Delete an NDMP service configuration instance of a NAS Server.|file_ndmp_delete|
