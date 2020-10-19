Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## Vcenter



```puppet
powerstore_vcenter {
  address => "address (optional)",
  id => "id",
  password => "password (optional)",
  username => "username (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|address | Optional[String] | false |
|id | String | true |
|password | Optional[String] | false |
|username | Optional[String] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the vcenter

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/vcenter`|Post|Add a vCenter. Not allowed in Unified+ deployments.|vcenter_create|
|List - list all|`/vcenter`|Get|Query registered vCenters.|vcenter_collection_query|
|List - get one|`/vcenter/%{id}`|Get|Query a specific vCenter instance.|vcenter_instance_query|
|List - get list using params|``||||
|Update|`/vcenter/%{id}`|Patch|Modify a vCenter settings.|vcenter_modify|
|Delete|`/vcenter/%{id}`|Delete|Delete a registered vCenter. Deletion of vCenter disables functionality that requires communication with vCenter. Not allowed in Unified+ deployments.|vcenter_delete|