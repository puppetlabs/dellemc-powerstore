Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## File_interface_route



```puppet
powerstore_file_interface_route {
  destination => "destination (optional)",
  file_interface_id => "file_interface_id",
  gateway => "gateway (optional)",
  id => "id",
  prefix_length => "1234 (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|destination | String | false |
|file_interface_id | String | true |
|gateway | String | false |
|id | String | true |
|prefix_length | Integer | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the file_interface_route

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/file_interface_route`|Post|Create and configure a new file interface route.
There are 3 route types Subnet, Default, and Host.
* The default route establishes a static route to a default gateway. To create a default route, provide only the default gateway IP address.
* The host route establishes a static route to a specific host. To create a host route, provide the IP address of the specific host in the destination field, and the gateway.
* The subnet route establishes a static route to a particular subnet. To create a subnet route, provide the IP address of the target subnet in the destination, the prefix length for that subnet, and the gateway.
|file_interface_routeCreate|
|List - list all|`/file_interface_route`|Get|Query file interface routes.|file_interface_routeCollectionQuery|
|List - get one|`/file_interface_route/%{id}`|Get|Query a specific file interface route for details.|file_interface_routeInstanceQuery|
|List - get list using params|``||||
|Update|`/file_interface_route/%{id}`|Patch|Modify file interface route settings.|file_interface_routeModify|
|Delete|`/file_interface_route/%{id}`|Delete|Delete file interface route.|file_interface_routeDelete|
