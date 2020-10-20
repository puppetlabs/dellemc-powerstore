Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## Import_session

Use the import_session resource type to initiate and manage the migration of volumes and consistency groups from a heritage Dell EMC storage system to a PowerStore storage system. The import is non-disruptive to hosts that access the volume during the import. The import process runs as a background job. Clients should poll the job status until the import completes.   Note: In these descriptions, LUNs are referred to as volumes and storage arrays are referred to as storage systems.

```puppet
powerstore_import_session {
  automatic_cutover => "automatic_cutover (optional)",
  description => "description (optional)",
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
|automatic_cutover | Optional[Boolean] | false |
|description | Optional[String[1,128]] | false |
|name | String[1,128] | true |
|protection_policy_id | Optional[String] | false |
|remote_system_id | String | true |
|scheduled_timestamp | Optional[String] | false |
|source_resource_id | String | true |
|volume_group_id | Optional[String] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the import_session

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/import_session`|Post|Create a new import session. The source storage system and hosts that access the volumes or consistency groups must be added prior to creating an import session. The volumes or consistency groups must be in a migration-ready state.|import_session_create|
|List - list all|`/import_session`|Get|Query import sessions.|import_session_collection_query|
|List - get one|`/import_session/%{id}`|Get|Query a specific session.|import_session_instance_query|
|List - get list using params|``||||
|Update|`/import_session/%{id}`|Patch|Modify the scheduled date and time of the specified import session.|import_session_modify|
|Delete|`/import_session/%{id}`|Delete|Delete an import session that is in a Completed, Failed, or Cancelled state. Delete removes the historical record of the import. To stop active import sessions, use the Cancel operation. You can delete the import session after cancelling it.|import_session_delete|
