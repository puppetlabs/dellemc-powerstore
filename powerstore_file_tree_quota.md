Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## File_tree_quota



```puppet
powerstore_file_tree_quota {
  description => "description (optional)",
  file_system_id => "file_system_id",
  hard_limit => "1234 (optional)",
  id => "id",
  is_user_quotas_enforced => "is_user_quotas_enforced (optional)",
  path => "path",
  soft_limit => "1234 (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|description | String | false |
|file_system_id | String | true |
|hard_limit | Integer | false |
|id | String | true |
|is_user_quotas_enforced | Boolean | false |
|path | String | true |
|soft_limit | Integer | false |



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
