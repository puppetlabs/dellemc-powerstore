Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## Replication_rule



```puppet
powerstore_replication_rule {
  alert_threshold => "1234 (optional)",
  id => "id",
  name => "name (optional)",
  remote_system_id => "remote_system_id (optional)",
  rpo => "rpo (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|alert_threshold | Integer | false |
|id | String | true |
|name | String | false |
|remote_system_id | String | false |
|rpo | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the replication_rule

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/replication_rule`|Post|Create a new replication rule.
|replication_ruleCreate|
|List - list all|`/replication_rule`|Get|Query all replication rules.|replication_ruleCollectionQuery|
|List - get one|`/replication_rule/%{id}`|Get|Query a specific replication rule.|replication_ruleInstanceQuery|
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
            
|replication_ruleModify|
|Delete|`/replication_rule/%{id}`|Delete|Delete a replication rule.

Deleting a rule is not permitted, if the rule is associated with a protection policy that
is currently applied to a storage resource.
|replication_ruleDelete|
