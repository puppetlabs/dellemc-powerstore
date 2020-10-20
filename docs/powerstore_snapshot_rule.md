Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## Snapshot_rule

Use this resource type to manage snapshot rules that are used in protection policies.

```puppet
powerstore_snapshot_rule {
  days_of_week => "days_of_week (optional)",
  delete_snaps => "delete_snaps (optional)",
  desired_retention => "desired_retention (optional)",
  interval => "interval (optional)",
  name => "name",
  time_of_day => "time_of_day (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|days_of_week | Optional[Array[Enum['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday']]] | false |
|delete_snaps | Optional[Boolean] | false |
|desired_retention | Optional[Integer[1,8760]] | false |
|interval | Optional[Enum['Five_Minutes','Fifteen_Minutes','Thirty_Minutes','One_Hour','Two_Hours','Three_Hours','Four_Hours','Six_Hours','Eight_Hours','Twelve_Hours','One_Day']] | false |
|name | String | true |
|time_of_day | Optional[String] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the snapshot_rule

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/snapshot_rule`|Post|Create a new snapshot rule.
|snapshot_rule_create|
|List - list all|`/snapshot_rule`|Get|Query all snapshot rules.|snapshot_rule_collection_query|
|List - get one|`/snapshot_rule/%{id}`|Get|Query a specific snapshot rule.|snapshot_rule_instance_query|
|List - get list using params|``||||
|Update|`/snapshot_rule/%{id}`|Patch|Modify a snapshot rule.

If the rule is associated with a policy that is currently applied to
a storage resource, the modified rule is immediately applied
to that associated storage resource.
|snapshot_rule_modify|
|Delete|`/snapshot_rule/%{id}`|Delete|Delete a snapshot rule
|snapshot_rule_delete|
