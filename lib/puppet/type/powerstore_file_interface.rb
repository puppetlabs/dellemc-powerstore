require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_file_interface',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    gateway:          {
      type:      'Optional[String]',
      desc:      "Gateway address for the network interface. IPv4 and IPv6 are supported.",
      behaviour: :init_only,
    },
    id:          {
      type:      'String',
      desc:      "Unique identifier of the file interface.",
      behaviour: :namevar,
    },
    ip_address:          {
      type:      'Optional[String]',
      desc:      "IP address of the network interface. IPv4 and IPv6 are supported.",
      behaviour: :init_only,
    },
    is_disabled:          {
      type:      'Optional[Boolean]',
      desc:      "Indicates whether the network interface is disabled.",
      behaviour: :init_only,
    },
    nas_server_id:          {
      type:      'String',
      desc:      "Unique identifier of the NAS server to which the network interface belongs, as defined by the nas_server resource type.",
      behaviour: :init_only,
    },
    prefix_length:          {
      type:      'Optional[Integer]',
      desc:      "Prefix length for the interface. IPv4 and IPv6 are supported.",
      behaviour: :init_only,
    },
    role:          {
      type:      'Optional[String]',
      desc:      "- Production - This type of network interface is used for all file protocols and services of a NAS server. This type of interface is inactive while a NAS server is in destination mode. - Backup  - This type of network interface is used only for NDMP/NFS backup or disaster recovery testing. This type of interface is always active in all NAS server modes.",
      behaviour: :init_only,
    },
    vlan_id:          {
      type:      'Optional[Integer]',
      desc:      "Virtual Local Area Network (VLAN) identifier for the interface. The interface uses the identifier to accept packets that have matching VLAN tags.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
