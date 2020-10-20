Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## File_tree_quota

Tree quota settings in the storage system. A tree quota instance represents a quota limit applied to a specific directory tree in a file system.

```puppet
powerstore_file_tree_quota {
  description => "description (optional)",
  file_system_id => "file_system_id",
  hard_limit => "hard_limit (optional)",
  is_user_quotas_enforced => "is_user_quotas_enforced (optional)",
  path => "path",
  soft_limit => "soft_limit (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|description | Optional[String] | false |
|file_system_id | String | true |
|hard_limit | Optional[Integer[0,9223372036854775807]] | false |
|is_user_quotas_enforced | Optional[Boolean] | false |
|path | String | true |
|soft_limit | Optional[Integer[0,9223372036854775807]] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the file_tree_quota

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/file_tree_quota`|Post|Create a tree quota instance.|file_tree_quota_create|
|List - list all|`/file_tree_quota`|Get|List tree quota instances.|file_tree_quota_collection_query|
|List - get one|`/file_tree_quota/%{id}`|Get|Query a tree quota instance.|file_tree_quota_instance_query|
|List - get list using params|``||||
|Update|`/file_tree_quota/%{id}`|Patch|Modify a tree quota instance.|file_tree_quota_modify|
|Delete|`/file_tree_quota/%{id}`|Delete|Delete a tree quota instance.|file_tree_quota_delete|
