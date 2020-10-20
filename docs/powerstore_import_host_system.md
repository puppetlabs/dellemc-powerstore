Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## Import_host_system

Use these resource types to manage import host systems. Import host enables communication with multipathing software on the host system to perform import operations. While configuring the import_host_system if the host is not present a new Host will be created. If Host is already present, the same Host will be updated with the import_host_system details. Also, import_host_system supports FC and ISCSI connections between Host and source arrays. So for a single import_host_system which supports both FC and ISCSI; there would be two Hosts entries for representing the FC and iSCSI connections.

```puppet
powerstore_import_host_system {
  agent_address => "agent_address",
  agent_port => "agent_port",
  chap_mutual_password => "chap_mutual_password (optional)",
  chap_mutual_username => "chap_mutual_username (optional)",
  chap_single_password => "chap_single_password (optional)",
  chap_single_username => "chap_single_username (optional)",
  os_type => "os_type",
  password => "password",
  user_name => "user_name",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|agent_address | String | true |
|agent_port | Integer[0,65535] | true |
|chap_mutual_password | Optional[String] | false |
|chap_mutual_username | Optional[String] | false |
|chap_single_password | Optional[String] | false |
|chap_single_username | Optional[String] | false |
|os_type | Enum['Windows','Linux','ESXi','Unknown'] | true |
|password | String | true |
|user_name | String | true |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the import_host_system

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/import_host_system`|Post|Add an import host system so that it can be mapped to a volume. Before mapping an import host system, ensure that a host agent is installed. Host agents can be installed on Linux, Windows, and ESXi host systems only.  While adding import_host_system if Host is not present a new Host shall be created. If Host is already present, the same Host will be updated with the import_host_system details.|import_host_system_create|
|List - list all|`/import_host_system`|Get|Query import host systems that are attached to volumes.|import_host_system_collection_query|
|List - get one|`/import_host_system/%{id}`|Get|Query a specific import host system instance.|import_host_system_instance_query|
|List - get list using params|``||||
|Update|``||||
|Delete|`/import_host_system/%{id}`|Delete|Delete an import host system. You cannot delete an import host system if there are import sessions active in the system referencing the import host system instance.|import_host_system_delete|
