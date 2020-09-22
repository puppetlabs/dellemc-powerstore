Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## Email_notify_destination



```puppet
powerstore_email_notify_destination {
  email_address => "email_address (optional)",
  id => "id",
  notify_critical => "notify_critical (optional)",
  notify_info => "notify_info (optional)",
  notify_major => "notify_major (optional)",
  notify_minor => "notify_minor (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|email_address | String | false |
|id | String | true |
|notify_critical | Boolean | false |
|notify_info | Boolean | false |
|notify_major | Boolean | false |
|notify_minor | Boolean | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the email_notify_destination

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/email_notify_destination`|Post|Add an email address to receive notifications.|email_notify_destinationCreate|
|List - list all|`/email_notify_destination`|Get|Query all email notification destinations.|email_notify_destinationCollectionQuery|
|List - get one|`/email_notify_destination/%{id}`|Get|Query a specific email notification destination.|email_notify_destinationInstanceQuery|
|List - get list using params|``||||
|Update|`/email_notify_destination/%{id}`|Patch|Modify an email notification destination.|email_notify_destinationModify|
|Delete|`/email_notify_destination/%{id}`|Delete|Delete an email notification destination.|email_notify_destinationDelete|
