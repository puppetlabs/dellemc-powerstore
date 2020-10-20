Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## Migration_session

Manage migration sessions.

```puppet
powerstore_migration_session {
  automatic_cutover => "automatic_cutover (optional)",
  destination_appliance_id => "destination_appliance_id (optional)",
  family_id => "family_id (optional)",
  force => "force (optional)",
  name => "name",
  resource_type => "resource_type (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|automatic_cutover | Optional[Boolean] | false |
|destination_appliance_id | Optional[String] | false |
|family_id | Optional[String] | false |
|force | Optional[Boolean] | false |
|name | Optional[String] | true |
|resource_type | Optional[Enum['volume','virtual_volume','volume_group']] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the migration_session

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/migration_session`|Post|Create a new migration session. For virtual volumes (vVols), the background copy is completed during this phase and the ownership of the vVol is transferred to the new appliance. For volumes and application groups, a migration session is created in this phase and no background copy is performed until either the sync or cutover operation is invoked. There are no interruptions to any services during this phase.|migration_session_create|
|List - list all|`/migration_session`|Get|Query migration sessions.|migration_session_collection_query|
|List - get one|`/migration_session/%{id}`|Get|Query a specific migration session.|migration_session_instance_query|
|List - get list using params|``||||
|Update|``||||
|Delete|`/migration_session/%{id}`|Delete|Delete a migration session. With the force option, a migration session can be deleted regardless of its state. All background activity is canceled before deleting the session.|migration_session_delete|
