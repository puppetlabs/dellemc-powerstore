Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## Physical_switch



```puppet
powerstore_physical_switch {
  connections => "connections (optional)",
  id => "id",
  name => "name (optional)",
  purpose => "purpose (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|connections | Array | false |
|id | String | true |
|name | String | false |
|purpose | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the physical_switch

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/physical_switch`|Post|Create a physical switch settings.|physical_switchCreate|
|List - list all|`/physical_switch`|Get|Query physical switches settings for a cluster.|physical_switchCollectionQuery|
|List - get one|`/physical_switch/%{id}`|Get|Query a specific physical switch settings.|physical_switchInstanceQuery|
|List - get list using params|``||||
|Update|`/physical_switch/%{id}`|Patch|Modify a physical switch settings.|physical_switchModify|
|Delete|`/physical_switch/%{id}`|Delete|Delete the physical switch settings.|physical_switchDelete|
