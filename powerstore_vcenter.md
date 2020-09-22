Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

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
|address | String | false |
|id | String | true |
|password | String | false |
|username | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the vcenter

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/vcenter`|Post|Add a vCenter. Not allowed in Unified+ deployments.|vcenterCreate|
|List - list all|`/vcenter`|Get|Query registered vCenters.|vcenterCollectionQuery|
|List - get one|`/vcenter/%{id}`|Get|Query a specific vCenter instance.|vcenterInstanceQuery|
|List - get list using params|``||||
|Update|`/vcenter/%{id}`|Patch|Modify a vCenter settings.|vcenterModify|
|Delete|`/vcenter/%{id}`|Delete|Delete a registered vCenter. Deletion of vCenter disables functionality that requires communication with vCenter. Not allowed in Unified+ deployments.|vcenterDelete|
