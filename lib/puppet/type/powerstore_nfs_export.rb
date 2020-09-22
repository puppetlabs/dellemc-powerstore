require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_nfs_export',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    add_no_access_hosts:          {
      type:      'Optional[Array]',
      desc:      "Hosts to add to the no_access_host list. Hosts can be entered by Hostname, IP addresses (IPv4, IPv6, IPv4/PrefixLength, IPv6/PrefixLenght, or IPv4/subnetmask), or Netgroups prefixed with @. Error if the host already exists in the list. Cannot be combined with no_access_hosts.",
      behaviour: :init_only,
    },
    add_read_only_hosts:          {
      type:      'Optional[Array]',
      desc:      "Hosts to add to the current read_only_hosts list. Hosts can be entered by Hostname, IP addresses (IPv4, IPv6, IPv4/PrefixLength, IPv6/PrefixLenght, or IPv4/subnetmask), or Netgroups prefixed with @. Error if the host already exists. Cannot combine with read_only_hosts.",
      behaviour: :init_only,
    },
    add_read_only_root_hosts:          {
      type:      'Optional[Array]',
      desc:      "Hosts to add to the current read_only_root_hosts list. Hosts can be entered by Hostname, IP addresses (IPv4, IPv6, IPv4/PrefixLength, IPv6/PrefixLenght, or IPv4/subnetmask), or Netgroups prefixed with @. Error if the host already exists. Cannot combine with read_only_root_hosts.",
      behaviour: :init_only,
    },
    add_read_write_hosts:          {
      type:      'Optional[Array]',
      desc:      "Hosts to add to the current read_write_hosts list. Hosts can be entered by Hostname, IP addresses (IPv4, IPv6, IPv4/PrefixLength, IPv6/PrefixLenght, or IPv4/subnetmask), or Netgroups prefixed with @. Error if Host is already exists. Cannot combine with read_write_hosts.",
      behaviour: :init_only,
    },
    add_read_write_root_hosts:          {
      type:      'Optional[Array]',
      desc:      "Hosts to add to the current read_write_root_hosts list. Hosts can be entered by Hostname, IP addresses (IPv4, IPv6, IPv4/PrefixLength, IPv6/PrefixLenght, or IPv4/subnetmask), or Netgroups prefixed with @. Error if the host already exists. Cannot combine with read_write_root_hosts.",
      behaviour: :init_only,
    },
    anonymous_gid:          {
      type:      'Optional[Integer]',
      desc:      "Specifies the group ID of the anonymous account.",
      behaviour: :init_only,
    },
    anonymous_uid:          {
      type:      'Optional[Integer]',
      desc:      "Specifies the user ID of the anonymous account.",
      behaviour: :init_only,
    },
    default_access:          {
      type:      'Optional[String]',
      desc:      "Default access level for all hosts that can access the Export.* No_Access- Deny access to the Export for the hosts.* Read_Only- Allow read only access to the Export for the hosts.* Read_Write- Allow read write access to the Export for the hosts.* Root - Allow read write access to the Export for the hosts. Allow access to the Export for root user.* Read_Only_Root- Allow read only root access to the Export for the hosts.",
      behaviour: :init_only,
    },
    description:          {
      type:      'Optional[String]',
      desc:      "NFS Export description.",
      behaviour: :init_only,
    },
    file_system_id:          {
      type:      'String',
      desc:      "Unique identifier of the file system on which the NFS Export will be created.",
      behaviour: :init_only,
    },
    id:          {
      type:      'String',
      desc:      "NFS Export object id.",
      behaviour: :init_only,
    },
    is_no_suid:          {
      type:      'Optional[Boolean]',
      desc:      "If set, do not allow access to set SUID. Otherwise, allow access.",
      behaviour: :init_only,
    },
    min_security:          {
      type:      'Optional[String]',
      desc:      "NFS enforced security type for users accessing an NFS Export.* Sys - Allow the user to authenticate with any NFS security types: UNIX, Kerberos, Kerberos with integrity, or Kerberos with encryption.* Kerberos - Allow only Kerberos security for user authentication.* Kerberos_With_Integrity- Allow only Kerberos with integrity and Kerberos with encryption security for user authentication.* Kerberos_With_Encryption- Allow only Kerberos with encryption security for user authentication.",
      behaviour: :init_only,
    },
    name:          {
      type:      'String',
      desc:      "NFS Export name.",
      behaviour: :namevar,
    },
    no_access_hosts:          {
      type:      'Optional[Array]',
      desc:      "Hosts with no access to the NFS export or its snapshots. Hosts can be entered by Hostname, IP addresses (IPv4, IPv6, IPv4/PrefixLength, IPv6/PrefixLenght, or IPv4/subnetmask), or Netgroups prefixed with @.",
      behaviour: :init_only,
    },
    path:          {
      type:      'String',
      desc:      "Local path to export relative to the file system root directory. With NFS, each export of a file_system or file_snap must have a unique local path.Before you can create additional Exports within an NFS shared folder, you must create directories within it from a Linux/Unix host that is connected to the file system. After a directory has been created from a mounted host, you can create a corresponding Export and set access permissions accordingly.",
      behaviour: :init_only,
    },
    read_only_hosts:          {
      type:      'Optional[Array]',
      desc:      "Hosts with read-only access to the NFS export and its snapshots. Hosts can be entered by Hostname, IP addresses (IPv4, IPv6, IPv4/PrefixLength, IPv6/PrefixLenght, or IPv4/subnetmask), or Netgroups prefixed with @.",
      behaviour: :init_only,
    },
    read_only_root_hosts:          {
      type:      'Optional[Array]',
      desc:      "Hosts with read-only and ready-only for root user access to the NFS Export and its snapshots. Hosts can be entered by Hostname, IP addresses (IPv4, IPv6, IPv4/PrefixLength, IPv6/PrefixLenght, or IPv4/subnetmask), Netgroups prefixed with @.",
      behaviour: :init_only,
    },
    read_write_hosts:          {
      type:      'Optional[Array]',
      desc:      "Hosts with read and write access to the NFS export and its snapshots. Hosts can be entered by Hostname, IP addresses (IPv4, IPv6, IPv4/PrefixLength, IPv6/PrefixLenght, or IPv4/subnetmask) or, Netgroups prefixed with @.",
      behaviour: :init_only,
    },
    read_write_root_hosts:          {
      type:      'Optional[Array]',
      desc:      "Hosts with read and write and read and write for root user access to the NFS Export and its snapshots. Hosts can be entered by Hostname, IP addresses (IPv4, IPv6, IPv4/PrefixLength, IPv6/PrefixLenght, or IPv4/subnetmask), or Netgroups prefixed with @.",
      behaviour: :init_only,
    },
    remove_no_access_hosts:          {
      type:      'Optional[Array]',
      desc:      "Hosts to remove from the current no_access_hosts list. Hosts can be entered by Hostname, IP addresses (IPv4, IPv6, IPv4/PrefixLength, IPv6/PrefixLenght, or IPv4/subnetmask), or Netgroups prefixed with @. Error if the host is not present. Cannot combine with no_access_hosts.",
      behaviour: :init_only,
    },
    remove_read_only_hosts:          {
      type:      'Optional[Array]',
      desc:      "Hosts to remove from the current read_only_hosts list. Hosts can be entered by Hostname, IP addresses (IPv4, IPv6, IPv4/PrefixLength, IPv6/PrefixLenght, or IPv4/subnetmask), or Netgroups prefixed with @. Error if the host is not present. Cannot combine with read_only_hosts.",
      behaviour: :init_only,
    },
    remove_read_only_root_hosts:          {
      type:      'Optional[Array]',
      desc:      "Hosts to remove from the current read_only_root_hosts list. Hosts can be entered by Hostname, IP addresses (IPv4, IPv6, IPv4/PrefixLength, IPv6/PrefixLenght, or IPv4/subnetmask), or Netgroups prefixed with @. Error if The host is not present. Cannot combine with read_only_root_hosts.",
      behaviour: :init_only,
    },
    remove_read_write_hosts:          {
      type:      'Optional[Array]',
      desc:      "Hosts to remove from the current read_write_hosts list. Hosts can be entered by Hostname, IP addresses (IPv4, IPv6, IPv4/PrefixLength, IPv6/PrefixLenght, or IPv4/subnetmask), or Netgroups prefixed with @. Error if Host is not present. Cannot combine with read_write_hosts.",
      behaviour: :init_only,
    },
    remove_read_write_root_hosts:          {
      type:      'Optional[Array]',
      desc:      "Hosts to remove from the current read_write_root_hosts list. Hosts can be entered by Hostname, IP addresses (IPv4, IPv6, IPv4/PrefixLength, IPv6/PrefixLenght, or IPv4/subnetmask), or Netgroups prefixed with @. Error if the host is not present. Cannot combine with read_write_root_hosts.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
