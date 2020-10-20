Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## Replication_rule

Use this resource type to manage the replication rules that are used in protection policies.

```puppet
powerstore_replication_rule {
  alert_threshold => "alert_threshold (optional)",
  name => "name",
  remote_system_id => "remote_system_id",
  rpo => "rpo",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|alert_threshold | Optional[Integer[0,1440]] | false |
|name | String | true |
|remote_system_id | String | true |
|rpo | Enum['Five_Minutes','Fifteen_Minutes','Thirty_Minutes','One_Hour','Six_Hours','Twelve_Hours','One_Day'] | true |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the replication_rule

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/replication_rule`|Post|Create a new replication rule.
|replication_rule_create|
|List - list all|`/replication_rule`|Get|Query all replication rules.|replication_rule_collection_query|
|List - get one|`/replication_rule/%{id}`|Get|Query a specific replication rule.|replication_rule_instance_query|
|List - get list using params|``||||
|Update|`/replication_rule/%{id}`|Patch|Modify a replication rule.

If the rule is associated with a policy that is currently applied to
a storage resource, the modified rule is immediately applied
to the associated storage resource.

Changing the remote_system_id is not permitted, if the rule is part of a policy that
is currently applied to a storage resource. To change the remote system associated with a
replication rule, do either of the following:

    Remove the protection policy association from the relevant storage resources, modify the replication rule, and then associate the storage resources with the relevant protection policies.
        Remove the replication rule from the protection policies that use it, modify the replication rule,
        and then associate it back with the relevant protection policies. 
            
|replication_rule_modify|
|Delete|`/replication_rule/%{id}`|Delete|Delete a replication rule.

Deleting a rule is not permitted, if the rule is associated with a protection policy that
is currently applied to a storage resource.
|replication_rule_delete|
