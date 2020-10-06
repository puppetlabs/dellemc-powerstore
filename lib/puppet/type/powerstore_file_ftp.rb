require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_file_ftp',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: "Enum['present', 'absent']",
      desc: "Whether this resource should be present or absent on the target system.",
      default: "present",
    },

    add_groups:          {
      type:      "Optional[Array[String]]",
      desc:      "Groups to add to the current groups. Error occurs if the group already exists. Cannot be combined with groups.",
    },
    add_hosts:          {
      type:      "Optional[Array[String]]",
      desc:      "Host IP addresses to add to the current hosts. The addresses may be IPv4 or IPv6. Error occurs if the IP address already exists. Cannot be combined with hosts.",
    },
    add_users:          {
      type:      "Optional[Array[String]]",
      desc:      "Users to add to the current users. Error occurs if the user already exist. Cannot be combined with users.",
    },
    audit_dir:          {
      type:      "Optional[String]",
      desc:      "(Applies when the value of is_audit_enabled is true.) Directory of FTP/SFTP audit files. Logs are saved in '/' directory (default) or in a mounted file system (Absolute path of the File system directory which should already exist).",
    },
    audit_max_size:          {
      type:      "Optional[Integer[40960, 9223372036854775808]]",
      desc:      "(Applies when the value of is_audit_enabled is true.) Maximum size of all (current plus archived) FTP/SFTP audit files, in bytes.There is a maximum of 5 audit files, 1 current audit file (ftp.log) and 4 archived audit files.The maximum value for this setting is 5GB (each file of 1GB) if the audit directory belongs to a user file system of the NAS server.If the audit directory is '/', the maximum value is 5MB (each file of 1MB).The minimum value is 40kB (each file of 8KB) on any file system.",
    },
    default_homedir:          {
      type:      "Optional[String]",
      desc:      "(Applies when the value of is_homedir_limit_enabled is false.) Default directory of FTP and SFTP clients who have a home directory that is not defined or accessible.",
    },
    groups:          {
      type:      "Optional[Array[String]]",
      desc:      "Allowed or denied user groups, depending on the value of the is_allowed_groups attribute.- If allowed groups exist, only users who are members of these groups and no others can connect to the NAS server through FTP or SFTP.- If denied groups exist, all users who are members of those groups always have access denied to the NAS server through FTP or SFTP.- If the list is empty, there is no restriction to the NAS server access through FTP or SFTP based on the user group.",
    },
    hosts:          {
      type:      "Optional[Array[String]]",
      desc:      "Allowed or denied hosts, depending on the value of the is_allowed_hosts attribute. A host is defined using its IP address. Subnets using CIDR notation are also supported.- If allowed hosts exist, only those hosts and no others can connect to the NAS server through FTP or SFTP.- If denied hosts exist, they always have access denied to the NAS server through FTP or SFTP.- If the list is empty, there is no restriction to NAS server access through FTP or SFTP based on the host IP address.- The addresses may be IPv4 or IPv6.",
    },
    id:          {
      type:      "String",
      desc:      "Unique identifier of the FTP/SFTP Server object.",
      behaviour: :namevar,
    },
    is_allowed_groups:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether the groups attribute contains allowed or denied user groups. Values are:- true - groups contains allowed user groups.- false - groups contains denied user groups.",
    },
    is_allowed_hosts:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether the hosts attribute contains allowed or denied hosts. Values are:true - hosts contains allowed hosts.false - hosts contains denied hosts.",
    },
    is_allowed_users:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether the users attribute contains allowed or denied users. Values are:- true - users contains allowed users.- false - users contains denied users.",
    },
    is_anonymous_authentication_enabled:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether FTP clients can be authenticated anonymously. Values are:- true - Anonymous user name is accepted.- false - Anonymous user name is not accepted.",
    },
    is_audit_enabled:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether the activity of FTP and SFTP clients is tracked in audit files. Values are:- true - FTP/SFTP activity is tracked.- false - FTP/SFTP activity is not tracked.",
    },
    is_ftp_enabled:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether the FTP server is enabled on the NAS server specified in the nasServer attribute. Values are:- true - FTP server is enabled on the specified NAS server.- false - FTP server is disabled on the specified NAS server.",
    },
    is_homedir_limit_enabled:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether an FTP or SFTP user access is limited to the home directory of the user. Values are:- true - An FTP or SFTP user can access only the home directory of the user.- false - FTP and SFTP users can access any NAS server directory, according to NAS server permissions.",
    },
    is_sftp_enabled:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether the SFTP server is enabled on the NAS server specified in the nasServer attribute. Values are:- true - SFTP server is enabled on the specified NAS server.- false - SFTP server is disabled on the specified NAS server.",
    },
    is_smb_authentication_enabled:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether FTP and SFTP clients can be authenticated using an SMB user name. These user names are defined in a Windows domain controller, and their formats are user@domain or domain\\user. Values are:- true - SMB user names are accepted for authentication.- false - SMB user names are not accepted for authentication.",
    },
    is_unix_authentication_enabled:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether FTP and SFTP clients can be authenticated using a Unix user name. Unix user names are defined in LDAP, NIS servers or in local passwd file. Values are:- true - Unix user names are accepted for authentication.- false - Unix user names are not accepted for authentication.",
    },
    message_of_the_day:          {
      type:      "Optional[String]",
      desc:      "Message of the day displayed on the console of FTP clients after their authentication. The length of this message is limited to 511 bytes of UTF-8 characters, and the length of each line is limited to 80 bytes.",
    },
    nas_server_id:          {
      type:      "String",
      desc:      "Unique identifier of the NAS server that is configured with the FTP server.",
      behaviour: :init_only,
    },
    remove_groups:          {
      type:      "Optional[Array[String]]",
      desc:      "Groups to remove from the current groups. Error occurs if the group is not present. Cannot be combined with groups.",
    },
    remove_hosts:          {
      type:      "Optional[Array[String]]",
      desc:      "Host IP addresses to remove from the current hosts. The addresses may be IPv4 or IPv6. Error occurs if the IP address is not present. Cannot be combined with hosts.",
    },
    remove_users:          {
      type:      "Optional[Array[String]]",
      desc:      "Users to remove from the current users. Error occurs if the user is not present. Cannot be combined with users.",
    },
    users:          {
      type:      "Optional[Array[String]]",
      desc:      "Allowed or denied users, depending on the value of the is_allowed_user attribute.- If allowed users exist, only those users and no others can connect to the NAS server through FTP or SFTP.- If denied users exist, they have always access denied to the NAS server through FTP or SFTP.- If the list is empty, there is no restriction to the NAS server access through FTP or SFTP based on the user name.",
    },
    welcome_message:          {
      type:      "Optional[String]",
      desc:      "Welcome message displayed on the console of FTP and SFTP clients before their authentication. The length of this message is limited to 511 bytes of UTF-8 characters, and the length of each line is limited to 80 bytes.",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
