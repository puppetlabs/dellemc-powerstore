Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## Email_notify_destination

Use these resource types to configure outgoing SMTP and email notifications.

```puppet
powerstore_email_notify_destination {
  email_address => "email_address (optional)",
  notify_critical => "notify_critical (optional)",
  notify_info => "notify_info (optional)",
  notify_major => "notify_major (optional)",
  notify_minor => "notify_minor (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|email_address | Optional[String] | false |
|notify_critical | Optional[Boolean] | false |
|notify_info | Optional[Boolean] | false |
|notify_major | Optional[Boolean] | false |
|notify_minor | Optional[Boolean] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the email_notify_destination

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/email_notify_destination`|Post|Add an email address to receive notifications.|email_notify_destination_create|
|List - list all|`/email_notify_destination`|Get|Query all email notification destinations.|email_notify_destination_collection_query|
|List - get one|`/email_notify_destination/%{id}`|Get|Query a specific email notification destination.|email_notify_destination_instance_query|
|List - get list using params|``||||
|Update|`/email_notify_destination/%{id}`|Patch|Modify an email notification destination.|email_notify_destination_modify|
|Delete|`/email_notify_destination/%{id}`|Delete|Delete an email notification destination.|email_notify_destination_delete|
