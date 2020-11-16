require 'puppet/resource_api'

# rubocop:disable Style/StringLiterals
Puppet::ResourceApi.register_type(
  name: 'powerstore_vcenter',
  features: ['remote_resource'],
  # rubocop:disable Lint/UnneededDisable
  # rubocop:disable Layout/TrailingWhitespace
  desc: <<-EOS,
    Use this resource type to manage vCenter instances. Registered vCenter enables discovering of virtual machines, managing virtual machine snapshots, automatic mounting of storage container and other functionality that requires communication with vCenter. In Unified+ deployments, the one vCenter instance residing in the PowerStore cluster will be prepopulated here and cannot be deleted, nor may any other vCenters be added. For Unified deployments, one external vCenter may be configured if desired.
  EOS
  attributes:   {
    ensure:      {
      type:      "Enum['present', 'absent']",
      desc:      'Whether this resource should be present or absent on the target system.',
      default:   'present',
    },
    address:          {
      type:      "Optional[String]",
      desc:      "IP address of vCenter host, in IPv4, IPv6, or hostname format.",
    },
    id:          {
      type:      "String",
      desc:      "Unique identifier of the vCenter to delete.",
      behaviour: :namevar,
    },
    instance_uuid:          {
      type:      "Optional[String]",
      desc:      "UUID instance of the vCenter.",
    },
    password:          {
      type:      "Optional[String]",
      desc:      "Password to login to vCenter.",
    },
    username:          {
      type:      "Optional[String]",
      desc:      "User name to login to vCenter.",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
