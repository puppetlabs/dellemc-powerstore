require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_host',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: "Enum['present', 'absent']",
      desc: "Whether this resource should be present or absent on the target system.",
      default: "present",
    },

    add_initiators:          {
      type:      "Optional[Array[Struct[{Optional[chap_mutual_password] => String[12,64], Optional[chap_mutual_username] => String[1,64], Optional[chap_single_password] => String[12,64], Optional[chap_single_username] => String[1,64], port_name => String, port_type => Enum['iSCSI','FC'], }]]]",
      desc:      "The list of initiators to be added. CHAP username and password are optional.",
    },
    description:          {
      type:      "Optional[String]",
      desc:      "An optional description for the host. The description should not be more than 256 UTF-8 characters long and should not have any unprintable characters.",
    },
    id:          {
      type:      "String",
      desc:      "Unique id of the host.",
      behaviour: :init_only,
    },
    initiators:          {
      type:      "Array[Struct[{port_name => String, port_type => Enum['iSCSI','FC'], Optional[chap_mutual_password] => String[12,64], Optional[chap_mutual_username] => String[1,64], Optional[chap_single_password] => String[12,64], Optional[chap_single_username] => String[1,64], }]]",
      desc:      "",
      behaviour: :init_only,
    },
    modify_initiators:          {
      type:      "Optional[Array[Struct[{Optional[chap_mutual_password] => String[12,64], Optional[chap_mutual_username] => String[1,64], Optional[chap_single_password] => String[12,64], Optional[chap_single_username] => String[1,64], Optional[port_name] => String, }]]]",
      desc:      "Update list of existing initiators, identified by port_name, with new CHAP usernames and/or passwords.",
    },
    name:          {
      type:      "String",
      desc:      "The host name. The name should not be more than 128 UTF-8 characters long and should not have any unprintable characters.",
      behaviour: :namevar,
    },
    os_type:          {
      type:      "Enum['Windows','Linux','ESXi','AIX','HP-UX','Solaris']",
      desc:      "Operating system of the host.",
      behaviour: :init_only,
    },
    remove_initiators:          {
      type:      "Optional[Array[String]]",
      desc:      "The list of initiator port_names to be removed.",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
