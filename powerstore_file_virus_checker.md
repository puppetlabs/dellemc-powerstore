Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## File_virus_checker



```puppet
powerstore_file_virus_checker {
  id => "id",
  is_enabled => "is_enabled",
  nas_server_id => "nas_server_id",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|id | String | true |
|is_enabled | Boolean | true |
|nas_server_id | String | true |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the file_virus_checker

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/file_virus_checker`|Post|Add a new virus checker setting to a NAS Server. Only one instance can be created per NAS Server.
Workflow to enable the virus checker settings on the NAS Server is as follows: \n
1. Create a virus checker instance on NAS Server.
2. Download template virus checker configuration file.
3. Edit the configuration file with virus checker configuration details.
4. Upload the configuration file.
5. Enable the virus checker on the NAS Server.
|file_virus_checkerCreate|
|List - list all|`/file_virus_checker`|Get|Query all virus checker settings of the NAS Servers.|file_virus_checkerCollectionQuery|
|List - get one|`/file_virus_checker/%{id}`|Get|Query a specific virus checker setting of a NAS Server.|file_virus_checkerInstanceQuery|
|List - get list using params|``||||
|Update|`/file_virus_checker/%{id}`|Patch|Modify the virus checker settings of a NAS Server.|file_virus_checkerModify|
|Delete|`/file_virus_checker/%{id}`|Delete|Delete virus checker settings of a NAS Server.|file_virus_checkerDelete|
