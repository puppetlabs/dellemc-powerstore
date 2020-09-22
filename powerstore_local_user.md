Document: "dellemc.swagger"


Path: "/varhttps://github.com/aws/aws-sdk-go-v2/tree/master/dellemc.swagger.json")

## Local_user



```puppet
powerstore_local_user {
  current_password => "current_password (optional)",
  id => "id",
  is_locked => "is_locked (optional)",
  name => "name",
  password => "password (optional)",
  role_id => "role_id (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|current_password | String | false |
|id | String | true |
|is_locked | Boolean | false |
|name | String | true |
|password | String | false |
|role_id | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the local_user

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/local_user`|Post|Create a new local user account. Any existing local user with either an administrator or a security administrator role can create a new local user account. By default, a new local_user account is NOT locked.|local_userCreate|
|List - list all|`/local_user`|Get|Query all local user account instances. 
This resource type collection query does not support filtering, sorting or pagination|local_userCollectionQuery|
|List - get one|`/local_user/%{id}`|Get|Query a specific local user account instance using an unique identifier.|local_userInstanceQuery|
|List - get list using params|``||||
|Update|`/local_user/%{id}`|Patch|Modify a property of a local user account using the unique identifier. You cannot modify the default "admin" user account.|local_userModify|
|Delete|`/local_user/%{id}`|Delete|Delete a local user account instance using the unique identifier. You cannot delete the default "admin" account or the account you are currently logged into. Any local user account with Administrator or Security Administrator role can delete any other local user account except the default "admin" account.|local_userDelete|
