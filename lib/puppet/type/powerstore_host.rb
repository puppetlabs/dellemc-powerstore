require 'puppet/resource_api'

# rubocop:disable Style/StringLiterals
Puppet::ResourceApi.register_type(
  name: 'powerstore_host',
  features: ['remote_resource'],
  # rubocop:disable Lint/UnneededDisable
  # rubocop:disable Layout/TrailingWhitespace
  desc: <<-EOS,
    Manage hosts that access the cluster.
  EOS
  attributes:   {
    ensure:      {
      type:      "Enum['present', 'absent']",
      desc:      'Whether this resource should be present or absent on the target system.',
      default:   'present',
    },
    add_initiators:          {
      type:      "Optional[Array[Struct[{Optional[chap_mutual_password] => Optional[String[12,64]], Optional[chap_mutual_username] => Optional[String[1,64]], Optional[chap_single_password] => Optional[String[12,64]], Optional[chap_single_username] => Optional[String[1,64]], port_name => Optional[String], port_type => Optional[Enum['iSCSI','FC']], }]]]",
      desc:      "The list of initiators to be added. CHAP username and password are optional.",
    },
    description:          {
      type:      "Optional[String[0,256]]",
      desc:      "An optional description for the host. The description should not be more than 256 UTF-8 characters long and should not have any unprintable characters.",
    },
    host_group_id:          {
      type:      "Optional[String]",
      desc:      "Associated host group, if host is part of host group.",
    },
    host_initiators:          {
      type:      "Optional[Array[Struct[{Optional[active_sessions] => Optional[Array[Struct[{Optional[appliance_id] => Optional[String], Optional[bond_id] => Optional[String], Optional[eth_port_id] => Optional[String], Optional[fc_port_id] => Optional[String], Optional[node_id] => Optional[String], Optional[port_name] => Optional[String], Optional[veth_id] => Optional[String], }]]], Optional[chap_mutual_username] => Optional[String[1,64]], Optional[chap_single_username] => Optional[String[1,64]], Optional[port_name] => Optional[String], Optional[port_type] => Optional[Enum['iSCSI','FC']], Optional[port_type_l10n] => Optional[String], }]]]",
      desc:      "Filtering on the fields of this embedded resource is not supported.",
    },
    id:          {
      type:      "Optional[String]",
      desc:      "Unique id of the host.",
      behaviour: :read_only,
    },
    initiators:          {
      type:      "Optional[Array[Struct[{Optional[chap_mutual_password] => Optional[String[12,64]], Optional[chap_mutual_username] => Optional[String[1,64]], Optional[chap_single_password] => Optional[String[12,64]], Optional[chap_single_username] => Optional[String[1,64]], port_name => Optional[String], port_type => Optional[Enum['iSCSI','FC']], }]]]",
      desc:      "",
      behaviour: :init_only,
    },
    modify_initiators:          {
      type:      "Optional[Array[Struct[{Optional[chap_mutual_password] => Optional[String[12,64]], Optional[chap_mutual_username] => Optional[String[1,64]], Optional[chap_single_password] => Optional[String[12,64]], Optional[chap_single_username] => Optional[String[1,64]], Optional[port_name] => Optional[String], }]]]",
      desc:      "Update list of existing initiators, identified by port_name, with new CHAP usernames and/or passwords.",
    },
    name:          {
      type:      "String[0,128]",
      desc:      "The host name. The name should not be more than 128 UTF-8 characters long and should not have any unprintable characters.",
      behaviour: :namevar,
    },
    os_type:          {
      type:      "Optional[Enum['Windows','Linux','ESXi','AIX','HP-UX','Solaris']]",
      desc:      "Operating system of the host.",
      behaviour: :init_only,
    },
    os_type_l10n:          {
      type:      "Optional[String]",
      desc:      "Localized message string corresponding to os_type",
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
