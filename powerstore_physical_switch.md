Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

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
|connections | Array[Struct[{address => String[1,255], connect_method => Enum['SSH','SNMPv2c'], Optional[port] => Integer[0,65535], Optional[snmp_community_string] => String, Optional[ssh_password] => String, Optional[username] => String, }]] | false |
|id | String | true |
|name | String[1,128] | false |
|purpose | Enum['Data_and_Management','Management_Only'] | false |



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
