Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## Snapshot_rule



```puppet
powerstore_snapshot_rule {
  days_of_week => "days_of_week (optional)",
  desired_retention => "1234 (optional)",
  id => "id",
  interval => "interval (optional)",
  name => "name (optional)",
  time_of_day => "time_of_day (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|days_of_week | Array | false |
|desired_retention | Integer | false |
|id | String | true |
|interval | String | false |
|name | String | false |
|time_of_day | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the snapshot_rule

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/snapshot_rule`|Post|Create a new snapshot rule.
|snapshot_ruleCreate|
|List - list all|`/snapshot_rule`|Get|Query all snapshot rules.|snapshot_ruleCollectionQuery|
|List - get one|`/snapshot_rule/%{id}`|Get|Query a specific snapshot rule.|snapshot_ruleInstanceQuery|
|List - get list using params|``||||
|Update|`/snapshot_rule/%{id}`|Patch|Modify a snapshot rule.

If the rule is associated with a policy that is currently applied to
a storage resource, the modified rule is immediately applied
to that associated storage resource.
|snapshot_ruleModify|
|Delete|`/snapshot_rule/%{id}`|Delete|Delete a snapshot rule
|snapshot_ruleDelete|
