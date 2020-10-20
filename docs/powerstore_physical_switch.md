Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## Physical_switch

Manage physical switches settings for the cluster.

```puppet
powerstore_physical_switch {
  connections => "connections (optional)",
  name => "name",
  purpose => "purpose (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|connections | Optional[Array[Struct[{address => Optional[String[1,255]], connect_method => Optional[Enum['SSH','SNMPv2c']], Optional[port] => Optional[Integer[0,65535]], Optional[snmp_community_string] => Optional[String[1,128]], Optional[ssh_password] => Optional[String[1,128]], Optional[username] => Optional[String[1,128]], }]]] | false |
|name | String[1,128] | true |
|purpose | Optional[Enum['Data_and_Management','Management_Only']] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the physical_switch

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/physical_switch`|Post|Create a physical switch settings.|physical_switch_create|
|List - list all|`/physical_switch`|Get|Query physical switches settings for a cluster.|physical_switch_collection_query|
|List - get one|`/physical_switch/%{id}`|Get|Query a specific physical switch settings.|physical_switch_instance_query|
|List - get list using params|``||||
|Update|`/physical_switch/%{id}`|Patch|Modify a physical switch settings.|physical_switch_modify|
|Delete|`/physical_switch/%{id}`|Delete|Delete the physical switch settings.|physical_switch_delete|
