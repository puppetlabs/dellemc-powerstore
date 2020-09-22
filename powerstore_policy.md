Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## Policy



```puppet
powerstore_policy {
  add_replication_rule_ids => "add_replication_rule_ids (optional)",
  add_snapshot_rule_ids => "add_snapshot_rule_ids (optional)",
  description => "description (optional)",
  id => "id",
  name => "name (optional)",
  remove_replication_rule_ids => "remove_replication_rule_ids (optional)",
  remove_snapshot_rule_ids => "remove_snapshot_rule_ids (optional)",
  replication_rule_ids => "replication_rule_ids (optional)",
  snapshot_rule_ids => "snapshot_rule_ids (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|add_replication_rule_ids | Array | false |
|add_snapshot_rule_ids | Array | false |
|description | String | false |
|id | String | true |
|name | String | false |
|remove_replication_rule_ids | Array | false |
|remove_snapshot_rule_ids | Array | false |
|replication_rule_ids | Array | false |
|snapshot_rule_ids | Array | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the policy

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/policy`|Post|Create a new protection policy. Protection policies can be assigned to volumes or volume groups. When a protection policy is assigned to a volume or volume group:
* If the policy is associated with one or more snapshot rules, scheduled snapshots are created based on the schedule specified in each snapshot rule.
* If the policy is associated with a replication rule, a replication session is created and synchronized based on the schedule specified in the replication rule.
|policyCreate|
|List - list all|`/policy`|Get|Query protection and performance policies.

The following REST query is an example of how to retrieve protection policies along with their rules and associated resources:

https://{{cluster_ip}}/api/rest/policy?select=name,id,type,replication_rules(id,name,rpo,remote_system(id,name,management_address)),snapshot_rules(id,name,interval,time_of_day,days_of_week),volume(id,name),volume_group(id,name)&type=eq.Protection

The following REST query is an example of how to retrieve performance policies along with their associated resources: 
  
https://{{cluster_ip}}/api/rest/policy?select=name,id,type,volume(id,name),volume_group(id,name)&type=eq.Performance
|policyCollectionQuery|
|List - get one|`/policy/%{id}`|Get|Query a specific policy.|policyInstanceQuery|
|List - get list using params|``||||
|Update|`/policy/%{id}`|Patch|Modify a protection policy.
|policyModify|
|Delete|`/policy/%{id}`|Delete|Delete a protection policy.

Protection policies that are used by any storage resources can not be deleted.
|policyDelete|
