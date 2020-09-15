Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## Remote_system



```puppet
powerstore_remote_system {
  data_network_latency => "data_network_latency (optional)",
  description => "description (optional)",
  discovery_chap_mode => "discovery_chap_mode (optional)",
  import_chap_info => "import_chap_info (optional)",
  iscsi_addresses => "iscsi_addresses (optional)",
  management_address => "management_address (optional)",
  name => "name (optional)",
  remote_password => "remote_password (optional)",
  remote_username => "remote_username (optional)",
  session_chap_mode => "session_chap_mode (optional)",
  type => "type (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|data_network_latency | String | false |
|description | String | false |
|discovery_chap_mode | String | false |
|import_chap_info | Hash | false |
|iscsi_addresses | Array | false |
|management_address | String | false |
|name | String | false |
|remote_password | String | false |
|remote_username | String | false |
|session_chap_mode | String | false |
|type | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the remote_system

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/remote_system`|Post|Create a new remote system relationship. The type of remote system being connected requires different parameter sets. 
For PowerStore remote system relationships, include the following parameters:
* Management address - Either an IPv4 or IPv6 address. FQDN is not supported.
* Type of remote system 
* Data network latency type




For PowerStore remote system relationships, the relationship is created in both directions. Remote protection policies can be configured using the PowerStore remote system instance on either of the systems. This enables remote replication for storage resources in either direction. The data connections take into account whether Challenge Handshake Authentication Protocol (CHAP) is enabled on local and remote PowerStore systems.




For non-PowerStore remote system relationships, include the following parameters:
* Management address - Either an IPv4 or IPv6 address. FQDN is not supported.
* Type of remote system
* Name
* Description
* Remote administrator credentials
* iSCSI address - IPv4 address
* CHAP mode for discovery or session 
* CHAP secrets details




After the remote system relationship is created, the local system can communicate with the remote system, and open data connections for data transfer.
|remote_systemCreate|
|List - list all|`/remote_system`|Get|Query remote systems.
|remote_systemCollectionQuery|
|List - get one|`/remote_system/%{id}`|Get|Query a remote system instance.
|remote_systemInstanceQuery|
|List - get list using params|``||||
|Update|`/remote_system/%{id}`|Patch|Modify a remote system instance. The list of valid parameters depends on the type of remote system.




For PowerStore remote system relationships:

* Description
* Management address - An IPv4 or IPv6 address. FQDN is not supported.




For non-PowerStore remote system relationships:

* Name
* Description
* Management address - An IPv4 address. FQDN is not supported.
* Remote administrator credentials
* iSCSI address - An IPv4 address.




After modifying the remote session instance, the system reestablishes the data connections as needed.
|remote_systemModify|
|Delete|`/remote_system/%{id}`|Delete|Delete a remote system. Deleting the remote system deletes the management and data connections established with the remote system. You cannot delete a remote system if there are active import sessions, or if there are remote protection policies active in the system referencing the remote system instance.




For PowerStore remote systems, the relationship is deleted in both directions if the remote system is up and connectable. You cannot delete a PowerStore remote system if there is no management connectivity between the local and remore systems. Only the local end of the relationship is deleted. Manually log in to the remote PowerStore system and remove the relationship.
|remote_systemDelete|
