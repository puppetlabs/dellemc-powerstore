Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## File_tree_quota



```puppet
powerstore_file_tree_quota {
  description => "description (optional)",
  file_system_id => "file_system_id (optional)",
  hard_limit => "hard_limit (optional)",
  id => "id",
  is_user_quotas_enforced => "is_user_quotas_enforced (optional)",
  path => "path (optional)",
  soft_limit => "soft_limit (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|description | String | false |
|file_system_id | String | false |
|hard_limit | Integer[0,9223372036854775807] | false |
|id | String | true |
|is_user_quotas_enforced | Boolean | false |
|path | String | false |
|soft_limit | Integer[0,9223372036854775807] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the file_tree_quota

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/file_tree_quota`|Post|Create a tree quota instance.|file_tree_quotaCreate|
|List - list all|`/file_tree_quota`|Get|List tree quota instances.|file_tree_quotaCollectionQuery|
|List - get one|`/file_tree_quota/%{id}`|Get|Query a tree quota instance.|file_tree_quotaInstanceQuery|
|List - get list using params|``||||
|Update|`/file_tree_quota/%{id}`|Patch|Modify a tree quota instance.|file_tree_quotaModify|
|Delete|`/file_tree_quota/%{id}`|Delete|Delete a tree quota instance.|file_tree_quotaDelete|
