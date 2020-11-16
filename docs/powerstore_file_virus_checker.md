Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## File_virus_checker

Use these resource types to manage the virus checker service of a NAS server. A virus checker instance is created each time the anti-virus service is enabled on a NAS server. A configuration file (named viruschecker.conf) needs to be uploaded before enabling the anti-virus service.
The cluster supports third-party anti-virus servers that perform virus scans and reports back to the storage system. For example, when an SMB client creates, moves, or modifies a file, the NAS server invokes the anti-virus server to scan the file for known viruses. During the scan any access to this file is blocked. If the file does not contain a virus, it is written to the file system. If the file is infected, corrective action (fixed, removed or placed in quarantine) is taken as defined by the anti-virus server. You can optionally set up the service to scan the file on read access based on last access of the file compared to last update of the third-party anti-virus date.


```puppet
powerstore_file_virus_checker {
  is_enabled => "is_enabled (optional)",
  nas_server_id => "nas_server_id (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|is_enabled | Optional[Boolean] | false |
|nas_server_id | Optional[String] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the file_virus_checker

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/file_virus_checker`|Post|Add a new virus checker setting to a NAS Server. Only one instance can be created per NAS Server.
Workflow to enable the virus checker settings on the NAS Server is as follows: \n
1. Create a virus checker instance on NAS Server.
2. Download template virus checker configuration file.
3. Edit the configuration file with virus checker configuration details.
4. Upload the configuration file.
5. Enable the virus checker on the NAS Server.
|file_virus_checker_create|
|List - list all|`/file_virus_checker`|Get|Query all virus checker settings of the NAS Servers.|file_virus_checker_collection_query|
|List - get one|`/file_virus_checker/%{id}`|Get|Query a specific virus checker setting of a NAS Server.|file_virus_checker_instance_query|
|List - get list using params|``||||
|Update|`/file_virus_checker/%{id}`|Patch|Modify the virus checker settings of a NAS Server.|file_virus_checker_modify|
|Delete|`/file_virus_checker/%{id}`|Delete|Delete virus checker settings of a NAS Server.|file_virus_checker_delete|
