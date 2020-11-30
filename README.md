# Puppet module for Dell EMC PowerStore

## Table of Contents

- [Puppet module for Dell EMC PowerStore](#puppet-module-for-dell-emc-powerstore)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [License](#license)
  - [Setup](#setup)
    - [Requirements](#requirements)
    - [Installation for use with Bolt](#installation-for-use-with-bolt)
- [Installation for use with Puppet Enterprise](#installation-for-use-with-puppet-enterprise)
  - [Usage with Bolt](#usage-with-bolt)
    - [Using Tasks](#using-tasks)
      - [Introduction to Dell EMC PowerStore tasks](#introduction-to-dell-emc-powerstore-tasks)
      - [Examples](#examples)
    - [Using Plans](#using-plans)
    - [Using Idempotent Puppet Resource Types](#using-idempotent-puppet-resource-types)
  - [Usage with Puppet Enterprise](#usage-with-puppet-enterprise)
  - [Reference](#reference)
  - [Limitations](#limitations)
  - [Development](#development)
    - [Installing PDK](#installing-pdk)
    - [Running syntax checks](#running-syntax-checks)
    - [Running unit tests](#running-unit-tests)
    - [Setting up the prism mock API server](#setting-up-the-prism-mock-api-server)
    - [Running type/provider acceptance tests](#running-typeprovider-acceptance-tests)
    - [Running task acceptance tests](#running-task-acceptance-tests)
    - [Generating REFERENCE.md](#generating-referencemd)
  - [Contributors](#contributors)
  - [Contact](#contact)
  - [Release Notes](#release-notes)

## Overview

The `dellemc-powerstore` module manages resources on Dell EMC PowerStore.

Dell EMC PowerStore is a next-generation midrange data storage solution targeted at customers who are looking for value, flexibility, and simplicity. Dell EMC PowerStore provides our customers with data-centric, intelligent, and adaptable infrastructure that supports both traditional and modern workloads.

The `dellemc-powerstore` Puppet module allows you to configure and deploy Dell EMC PowerStore using Puppet Bolt. To that end it offers resource types, tasks and plans.

## License

[Apache License version 2](LICENSE)

## Setup

### Requirements

 * Puppet Bolt `2.29.0` or later
 or
 * Puppet Enterprise `2019.8` or later

### Installation for use with Bolt

1. Follow [instructions for installing Puppet Bolt](https://puppet.com/docs/bolt/latest/bolt_installing.html).

1. Create a Bolt project with a name of your choosing, for example:
    ```bash
    mkdir pws
    cd pws
    bolt project init --modules dellemc-powerstore
    ```
    Your new Bolt project is ready to go. To list available plans, run
    ```bash
    bolt plan show
    ```
    To list all Bolt tasks related to the `volume` resource, run
    ```bash
    bolt task show --filter volume
    ```
    See [Bolt documentation](https://puppet.com/docs/bolt/latest/bolt.html) for more information on Puppet Bolt.

1. Create an `inventory.yaml` in your project directory, like so:
   ```yaml
    version: 2
    targets:
    - name: my_array
      uri: my.powerstore.host
      config:
        transport: remote
        remote:
          host: my.powerstore.host
          user: admin
          password: My$ecret!
          remote-transport: powerstore
   ```

# Installation for use with Puppet Enterprise

Installation of this module needs to be done using PE Code Manager. To that end, 

1. Add the following to the `Puppetfile`:

    ```bash
    mod 'dellemc-powerstore', :latest
    mod 'puppet-format', :latest
    ```
1. Perform a code deploy using Code Manager webhook, CD4PE or by using the command `puppet code deploy` on the Primary PE Server.
   
Note that it is often recommended to pin the installed modules to specific versions in the `Puppetfile`. For the purposes of this document, we use `:latest` which will fetch the latest available module version each time Code Manager code deploy is done in PE.

## Usage with Bolt

### Using Tasks

#### Introduction to Dell EMC PowerStore tasks

Every Dell EMC PowerStore API endpoint has a corresponding task. For example, for manipulating Dell EMC PowerStore volumes, the following tasks are available:
- volume_collection_query
- volume_instance_query
- volume_attach
- volume_clone
- volume_create
- volume_delete
- volume_detach
- volume_modify
- volume_refresh
- volume_restore
- volume_snapshot

Task usage is displayed by running `bolt task show`, for example:

```
bolt task show powerstore::volume_attach

powerstore::volume_attach - Attach a volume to a host or host group.

USAGE:
bolt task run --targets <node-name> powerstore::volume_attach host_group_id=<value> host_id=<value> id=<value> logical_unit_number=<value>

PARAMETERS:
- host_group_id: Optional[String]
    Unique identifier of the host group to be attached to the volume. Only one of host_id or host_group_id can be supplied.
- host_id: Optional[String]
    Unique identifier of the host to be attached to the volume. Only one of host_id or host_group_id can be supplied.
- id: String
    Unique identifier of volume to attach.
- logical_unit_number: Optional[Integer[0,16383]]
    Logical unit number for the host volume access.
```

The `--targets` parameter (abbreviated by `-t`) is the name of the device as configured in the inventory file (see above).

Every parameter is displayed along with its data type. Optional parameters have a type starting with the word `Optional`. So in the above example, the task accepts 4 parameters:
- `host_group_id`: optional String parameter
- `host_id`: optional String parameter
- `id`: required String parameter
- `logical_unit_number`: optional parameter, should be an Integer between 0 and 16383.

Tasks live in the `tasks/` folder of the module repository.

#### Examples

- Get a list of volumes:
  
  ```bash
  bolt task run powerstore::volume_collection_query -t my_array
  ```

- Get details of one volume:
  
  ```bash
  bolt task run powerstore::volume_instance_query id=<volume_id> -t my_array
  ```

- Create a volume:
  
  ```bash
  bolt task run powerstore::volume_create name="small_volume" size=1048576 description="Small Volume" -t my_array
  ```

### Using Plans

Plans are higher-level workflows that can leverage logic, tasks and commands to perform orchestrated operations on managed devices. Plans can be written using YAML or Puppet language (see documentation on [writing Plans](https://puppet.com/docs/bolt/latest/plans.html)). Example `dellemc-powerstore` plans can be found in the [plans](plans) directory of this repository and are documented [here](REFERENCE.md#plans).

For displaying usage information for a plan, run `bolt plan show`, for example:
```
> bolt plan show powerstore::capacity_volumes

powerstore::capacity_volumes - list volumes with more than given capacity

USAGE:
bolt plan run powerstore::capacity_volumes threshold=<value> targets=<value>

PARAMETERS:
- threshold: Variant[Numeric,String]
    Volume capacity needed (in bytes or MB/GB/TB)
- targets: TargetSpec
```

Example of running the plan:

```
> bolt plan run powerstore::capacity_volumes -t my_array threshold=220G
Starting: plan powerstore::capacity_volumes
Starting: task powerstore::volume_collection_query on my_array
Finished: task powerstore::volume_collection_query with 0 failures in 1.64 sec
+----------------------+-----------------+------------+
|        List of volumes with capacity > 220G         |
+----------------------+-----------------+------------+
| volume name          | capacity        | MB         |
+----------------------+-----------------+------------+
| Volume1              |  43980465111040 |   43.98 TB |
| my_large_volume      |    595926712320 |  595.93 GB |
| my_terabyte_volume   |   1099511627776 |    1.10 TB |
+----------------------+-----------------+------------+
Finished: plan powerstore::capacity_volumes in 1.94 sec
Plan completed successfully with no result
```

### Using Idempotent Puppet Resource Types

Tasks are an imperative way to query or manipulate state. In addition, the `dellemc-powerstore` module offers Puppet resource types which offer a declarative and idempotent way of managing the device's desired state.

Example of managing a volume called `my_volume` and ensuring it is created if it does not exist:

1. Example using YAML-language plan:
    ```yaml
        resources:
          - powerstore_volume: my_volume
            parameters:
              size: 26843545600
              description: My 25G Volume
              ensure: present
    ```
1. Example using a Puppet-language plan:
    ```puppet
          powerstore_volume { 'my_volume':
            ensure      => present,
            size        => 26843545600,
            description => 'My 25G Volume',
          }
    ```

See the [create_volume.pp](plans/create_volume.pp) and [create_volume_yaml.yaml](plans/create_volume_yaml.yaml) example plans showing a parametrized version of the above.

See the reference documentation for a list of all available [Resource types](REFERENCE.md#resource-types).

## Usage with Puppet Enterprise

After the module and its dependencies have been deployed inside PE (see [Installation for use with Puppet Enterprise](#installation-for-use-with-puppet-enterprise)), its tasks and plans should become usable in the PE Console and through the PE Orchestrator APIs.

You can onboard the devices using the Nodes | Add | Add Network Device menu option. Please enter the device's credentials (see the `inventory.yaml` above for an example of the credential parameters). After the device has been created you can start managing it as a standard PE node using Puppet manifests with resources and run tasks and plans against the device.

## Reference

Please see [REFERENCE](REFERENCE.md) for detailed information on available resource types, tasks and plans.

Direct links to the various parts of the reference documentation:

1. [Plans](REFERENCE.md#plans)
1. [Tasks](REFERENCE.md#tasks)
1. [Resource types](REFERENCE.md#resource-types)
1. [Functions](REFERENCE.md#functions)

## Limitations

The module has been tested on CentOS 7 and Windows 10 only but should work on any platform Bolt supports.

## Development

### Installing PDK

To run syntax checks and unit and acceptance tests, you need to first [install the Puppet Development Kit, or PDK](https://puppet.com/docs/pdk/1.x/pdk_install.html).

After installing, `cd` to the module directory to run various command explained below.

### Running syntax checks

```bash
> pdk validate
pdk (INFO): Using Ruby 2.5.8
pdk (INFO): Using Puppet 6.17.0
pdk (INFO): Running all available validators...
┌ [✔] Running metadata validators ...
├── [✔] Checking metadata syntax (metadata.json tasks/*.json).
└── [✔] Checking module metadata style (metadata.json).
┌ [✔] Running puppet validators ...
└── [✔] Checking Puppet manifest style (**/*.pp).
┌ [✔] Running ruby validators ...
└── [✔] Checking Ruby code style (**/**.rb).
┌ [✔] Running tasks validators ...
├── [✔] Checking task names (tasks/**/*).
└── [✔] Checking task metadata style (tasks/*.json).
┌ [✔] Running yaml validators ...
└── [✔] Checking YAML syntax (**/*.yaml **/*.yml).
```

### Running unit tests

```bash
> pdk test unit
```

You should expect to see something like this - the most important thing is that you should have 0 failures:
```bash
pdk (INFO): Using Ruby 2.5.8
pdk (INFO): Using Puppet 6.17.0
[✔] Preparing to run the unit tests.
......................................................................................................................

Finished in 2.25 seconds (files took 5.17 seconds to load)
118 examples, 0 failures
```

### Setting up the prism mock API server

The current acceptance test suite assumes that the `prism` API server is up and running. `prism` is a Open Source tool which can read an OpenAPI specification and generate a mock API server on the fly which is then able to validate incoming requests against the OpenAPI schemas and serve compliant responses with example data.

Although - in theory - it is possible to run acceptance tests against a real device, that is much harder to automate because of unknown `id`s of existing resources.

1. Install prism by following [the documentation](https://meta.stoplight.io/docs/prism/docs/getting-started/01-installation.md)
1. Make sure you have a copy of the Dell EMC PowerStore OpenAPI json file, let's call it `powerstore.json`
1. Remove all cyclical dependencies from the OpenAPI json file since `prism` does not support cycles inside OpenAPI specifications, producing the file `powerstore-nocycles.json`
1. Start the mock API server:
   ```bash
   prism mock powerstore-nocycles.json
   ```
   You will see something like:
   ```
   [5:43:55 PM] › [CLI] …  awaiting  Starting Prism…
   [5:43:56 PM] › [CLI] ℹ  info      GET        http://127.0.0.1:4010/appliance
   [5:43:56 PM] › [CLI] ℹ  info      GET        http://127.0.0.1:4010/appliance/vel
   [5:43:56 PM] › [CLI] ℹ  info      PATCH      http://127.0.0.1:4010/appliance/maiores
   [5:43:56 PM] › [CLI] ℹ  info      GET        http://127.0.0.1:4010/node
   [5:43:56 PM] › [CLI] ℹ  info      GET        http://127.0.0.1:4010/node/ut
   [5:43:56 PM] › [CLI] ℹ  info      GET        http://127.0.0.1:4010/network
   [5:43:56 PM] › [CLI] ℹ  info      GET        http://127.0.0.1:4010/network/dolor
   [5:43:56 PM] › [CLI] ℹ  info      PATCH      http://127.0.0.1:4010/network/placeat
   [5:43:56 PM] › [CLI] ℹ  info      POST       http://127.0.0.1:4010/network/adipisci/replace
   [5:43:56 PM] › [CLI] ℹ  info      POST       http://127.0.0.1:4010/network/nam/scale
   [5:43:56 PM] › [CLI] ℹ  info      GET        http://127.0.0.1:4010/ip_pool_address
   [5:43:56 PM] › [CLI] ℹ  info      GET        http://127.0.0.1:4010/ip_pool_address/pariatur
   ...
   ```

    The prism mock API server is now up and running on the default port 4010.

### Running type/provider acceptance tests

```bash
> MOCK_ACCEPTANCE=true pdk bundle rspec spec/acceptance
```
The test output will be something like this:
```
pdk (INFO): Using Ruby 2.5.8
pdk (INFO): Using Puppet 6.17.0
Running tests against this machine !
Run options: exclude {:update=>true, :bolt=>true}

powerstore_email_notify_destination
  get powerstore_email_notify_destination
  create powerstore_email_notify_destination
  delete powerstore_email_notify_destination
```
and the prism log will show something like this:

```
[5:47:39 PM] › [HTTP SERVER] get /email_notify_destination ℹ  info      Request received
[5:47:39 PM] ›     [NEGOTIATOR] ℹ  info      Request contains an accept header: */*
[5:47:39 PM] ›     [VALIDATOR] ✔  success   The request passed the validation rules. Looking for the best response
[5:47:39 PM] ›     [NEGOTIATOR] ✔  success   Found a compatible content for */*
[5:47:39 PM] ›     [NEGOTIATOR] ✔  success   Responding with the requested status code 200
[5:47:39 PM] › [HTTP SERVER] get /appliance ℹ  info      Request received
[5:47:39 PM] ›     [NEGOTIATOR] ℹ  info      Request contains an accept header: */*
[5:47:39 PM] ›     [VALIDATOR] ✔  success   The request passed the validation rules. Looking for the best response
[5:47:39 PM] ›     [NEGOTIATOR] ✔  success   Found a compatible content for */*
[5:47:39 PM] ›     [NEGOTIATOR] ✔  success   Responding with the requested status code 200
[5:47:39 PM] › [HTTP SERVER] post /email_notify_destination ℹ  info      Request received
[5:47:39 PM] ›     [NEGOTIATOR] ℹ  info      Request contains an accept header: */*
[5:47:39 PM] ›     [VALIDATOR] ✔  success   The request passed the validation rules. Looking for the best response
[5:47:39 PM] ›     [NEGOTIATOR] ✔  success   Found a compatible content for */*
[5:47:39 PM] ›     [NEGOTIATOR] ✔  success   Responding with the requested status code 201
[5:47:50 PM] › [HTTP SERVER] get /appliance ℹ  info      Request received
[5:47:50 PM] ›     [NEGOTIATOR] ℹ  info      Request contains an accept header: */*
[5:47:50 PM] ›     [VALIDATOR] ✔  success   The request passed the validation rules. Looking for the best response
[5:47:50 PM] ›     [NEGOTIATOR] ✔  success   Found a compatible content for */*
[5:47:50 PM] ›     [NEGOTIATOR] ✔  success   Responding with the requested status code 200
[5:47:50 PM] › [HTTP SERVER] get /email_notify_destination ℹ  info      Request received
[5:47:50 PM] ›     [NEGOTIATOR] ℹ  info      Request contains an accept header: */*
[5:47:50 PM] ›     [VALIDATOR] ✔  success   The request passed the validation rules. Looking for the best response
[5:47:50 PM] ›     [NEGOTIATOR] ✔  success   Found a compatible content for */*
[5:47:50 PM] ›     [NEGOTIATOR] ✔  success   Responding with the requested status code 200
[5:47:50 PM] › [HTTP SERVER] get /appliance ℹ  info      Request received
[5:47:50 PM] ›     [NEGOTIATOR] ℹ  info      Request contains an accept header: */*
[5:47:50 PM] ›     [VALIDATOR] ✔  success   The request passed the validation rules. Looking for the best response
[5:47:50 PM] ›     [NEGOTIATOR] ✔  success   Found a compatible content for */*
[5:47:50 PM] ›     [NEGOTIATOR] ✔  success   Responding with the requested status code 200
[5:47:50 PM] › [HTTP SERVER] delete /email_notify_destination/string ℹ  info      Request received
[5:47:50 PM] ›     [NEGOTIATOR] ℹ  info      Request contains an accept header: */*
[5:47:50 PM] ›     [VALIDATOR] ✔  success   The request passed the validation rules. Looking for the best response
[5:47:50 PM] ›     [NEGOTIATOR] ✔  success   Found a compatible content for */*
[5:47:50 PM] ›     [NEGOTIATOR] ✔  success   Responding with the requested status code 204
```

The `get /appliance` request is done for authentication purposes.

### Running task acceptance tests

To execute all available acceptance tests for tasks, run the following:

```
> MOCK_ACCEPTANCE=true pdk bundle exec rspec spec/task
pdk (INFO): Using Ruby 2.5.8
pdk (INFO): Using Puppet 6.17.0
Run options: exclude {:update=>true, :bolt=>true}

powerstore_email_notify_destination
  performs email_notify_destination_collection_query
  performs email_notify_destination_instance_query
  performs email_notify_destination_delete
  performs email_notify_destination_create
  performs email_notify_destination_test
...
```

To run a subset of task tests, for example volume-related, do:
```
> MOCK_ACCEPTANCE=true pdk bundle exec rspec spec/task -e volume
```

### Generating REFERENCE.md

To (re-)generate the REFERENCE.md file which documents the available types, tasks, functions and plans, run:

```
pdk bundle exec rake strings:generate:reference
```

## Contributors

## Contact

... forthcoming ...

## Release Notes

See [CHANGELOG](CHANGELOG.md)