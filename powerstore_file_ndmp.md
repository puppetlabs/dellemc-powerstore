Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## File_ndmp



```puppet
powerstore_file_ndmp {
  id => "id",
  nas_server_id => "nas_server_id",
  password => "password (optional)",
  user_name => "user_name (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|id | String | true |
|nas_server_id | String | true |
|password | String | false |
|user_name | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the file_ndmp

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/file_ndmp`|Post|Add an NDMP service configuration to a NAS server. Only one NDMP service object can be configured per NAS server.|file_ndmpCreate|
|List - list all|`/file_ndmp`|Get|List configured NDMP service instances.|file_ndmpCollectionQuery|
|List - get one|`/file_ndmp/%{id}`|Get|Query an NDMP service configuration instance.|file_ndmpInstanceQuery|
|List - get list using params|``||||
|Update|`/file_ndmp/%{id}`|Patch|Modify an NDMP service configuration instance.|file_ndmpModify|
|Delete|`/file_ndmp/%{id}`|Delete|Delete an NDMP service configuration instance of a NAS Server.|file_ndmpDelete|
