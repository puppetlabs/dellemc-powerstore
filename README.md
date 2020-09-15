
# Kubernetes Tasks

  

#### Table of contents

  

1. [Description](#description)

2. [Setup](#setup)

   * [Install the module](#installing-the-module)

3. [Usage](#usage)

   * [Run a task](#run-a-task)

   * [Examples](examples)

  

## Description

  

This repository contains the [Puppet Bolt](https://puppet.com/docs/bolt/0.x/bolt.html) tasks generated from [Kubernetes OpenAPI specs](https://raw.githubusercontent.com/kubernetes/kubernetes/master/api/openapi-spec/swagger.json) allowing users to interact with the Kubernetes API to create deployments, pods, services, etc.

## Setup

  

### Installing the module

  

To install the module, run the following command:

  

```

puppet module install puppetlabs-kubernetes

```

  

## Usage

  
### Run a task

  
All Bolt tasks accept as parameters the Kubernetes API endpoint (kube_api),  the authentication token (token) and the certificate authority file (ca_file) to obtain the secure access to the cluster. 

List Kubernetes nodes:
  

`bolt task run --nodes localhost k8s::swagger_k8s_list_core_v1_namespace kube_api=$KUBE_API`

  

### Examples

  

In the [examples](https://github.com/puppetlabs/puppetlabs-kubernetes/blob/master/examples) directory you will find:


* [task_examples.sh](https://github.com/puppetlabs/puppetlabs-kubenetes/blob/master/examples/task_examples.sh) contains a number of sample tasks, each using [Puppet Bolt](https://puppet.com/docs/bolt/0.x/bolt.html):

  * list Kubernetes namespaces

  * create a Kubernetes Nginx pod

  * create a Kubernetes deployment using a deployment YAML file

  * create a Kubernetes service

 