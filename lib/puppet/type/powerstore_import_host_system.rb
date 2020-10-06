require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_import_host_system',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: "Enum['present', 'absent']",
      desc: "Whether this resource should be present or absent on the target system.",
      default: "present",
    },

    agent_address:          {
      type:      "String",
      desc:      "Hostname or IPv4 address of the import host system.",
      behaviour: :init_only,
    },
    agent_port:          {
      type:      "Integer[0,65535]",
      desc:      "TCP port of the import host system.",
      behaviour: :init_only,
    },
    chap_mutual_password:          {
      type:      "Optional[String]",
      desc:      "Password for mutual CHAP authentication. This password is required when the cluster is using mutual authentication CHAP mode.",
      behaviour: :init_only,
    },
    chap_mutual_username:          {
      type:      "Optional[String]",
      desc:      "Username for mutual CHAP authentication. This username is required when the cluster is using mutual authentication CHAP mode.",
      behaviour: :init_only,
    },
    chap_single_password:          {
      type:      "Optional[String]",
      desc:      "Password for single CHAP authentication. This password is required when the cluster is using single authentication CHAP mode.",
      behaviour: :init_only,
    },
    chap_single_username:          {
      type:      "Optional[String]",
      desc:      "Username for single CHAP authentication. This username is required when the cluster is using single authentication CHAP mode.",
      behaviour: :init_only,
    },
    id:          {
      type:      "String",
      desc:      "Unique identifier of the import host system",
      behaviour: :namevar,
    },
    os_type:          {
      type:      "Enum['Windows','Linux','ESXi','Unknown']",
      desc:      "Operating system of the import host system. Valid values are: * Windows - Windows.  * Linux - Linux.  * ESXi - ESXi.  * Unknown - Operating system of the host system is unknown to PowerStore.",
      behaviour: :init_only,
    },
    password:          {
      type:      "String",
      desc:      "Password for the specified username.",
      behaviour: :init_only,
    },
    user_name:          {
      type:      "String",
      desc:      "Username for the import host system.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
