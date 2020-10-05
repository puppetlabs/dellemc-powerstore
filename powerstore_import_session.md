Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## Import_session



```puppet
powerstore_import_session {
  automatic_cutover => "automatic_cutover (optional)",
  description => "description (optional)",
  id => "id",
  name => "name",
  protection_policy_id => "protection_policy_id (optional)",
  remote_system_id => "remote_system_id",
  scheduled_timestamp => "scheduled_timestamp (optional)",
  source_resource_id => "source_resource_id",
  volume_group_id => "volume_group_id (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|automatic_cutover | Boolean | false |
|description | String | false |
|id | String | true |
|name | String | true |
|protection_policy_id | String | false |
|remote_system_id | String | true |
|scheduled_timestamp | String | false |
|source_resource_id | String | true |
|volume_group_id | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the import_session

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/import_session`|Post|Create a new import session. The source storage system and hosts that access the volumes or consistency groups must be added prior to creating an import session. The volumes or consistency groups must be in a migration-ready state.|import_sessionCreate|
|List - list all|`/import_session`|Get|Query import sessions.|import_sessionCollectionQuery|
|List - get one|`/import_session/%{id}`|Get|Query a specific session.|import_sessionInstanceQuery|
|List - get list using params|``||||
|Update|`/import_session/%{id}`|Patch|Modify the scheduled date and time of the specified import session.|import_sessionModify|
|Delete|`/import_session/%{id}`|Delete|Delete an import session that is in a Completed, Failed, or Cancelled state. Delete removes the historical record of the import. To stop active import sessions, use the Cancel operation. You can delete the import session after cancelling it.|import_sessionDelete|
