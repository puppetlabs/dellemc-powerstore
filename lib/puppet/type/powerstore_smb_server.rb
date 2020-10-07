require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_smb_server',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: "Enum['present', 'absent']",
      desc: "Whether this resource should be present or absent on the target system.",
      default: "present",
    },

    computer_name:          {
      type:      "Optional[String[1,63]]",
      desc:      "DNS name of the associated computer account when the SMB server is joined to an Active Directory domain.This name is limited to 63 bytes and must not contain the following characters -  - comma (.)  - tilde (~)  - colon (:)  - exclamation point (!)  - at sign (@)  - number sign (#)  - dollar sign ($)  - percent (%)  - caret (^)  - ampersand (&)  - apostrophe (')  - period (.) - note that if you enter string with period only the first word will be kept  - parentheses (())  - braces ({})  - underscore (_)  - white space (blank)as defined by the Microsoft naming convention (see https://support.microsoft.com/en-us/help/909264/)",
    },
    description:          {
      type:      "Optional[String[0,48]]",
      desc:      "Description of the SMB server in UTF-8 characters.",
    },
    domain:          {
      type:      "Optional[String[1,255]]",
      desc:      "Domain name where SMB server is registered in Active Directory, if applicable.",
    },
    force:          {
      type:      "Optional[Boolean]",
      desc:      "If false, the delete will fail if the SMB server is still joined, else the SMB server is deleted but AD account is not removed.",
    },
    id:          {
      type:      "String",
      desc:      "Unique identifier of the SMB server.",
      behaviour: :namevar,
    },
    is_standalone:          {
      type:      "Boolean",
      desc:      "Indicates whether the SMB server is standalone. Values are:- true - SMB server is standalone.- false - SMB server is joined to the Active Directory.",
    },
    local_admin_password:          {
      type:      "String[0,512]",
      desc:      "Regardless of the type of the SMB server, standalone or in the domain, a local administrator user must be created. local_admin_password is the password of this user.",
    },
    nas_server_id:          {
      type:      "String",
      desc:      "Unique identifier of the NAS server.",
      behaviour: :init_only,
    },
    netbios_name:          {
      type:      "Optional[String[1,15]]",
      desc:      "NetBIOS name is the network name of the standalone SMB server.SMB servers joined to Active Directory also have NetBIOS Name, defaulted to the 15 first characters of the computer_name attribute.Administrators can specify a custom NetBIOS Name for a SMB server using this attribute.NetBIOS name is limited to 15 characters and cannot contain the following characters -  - backslash (\)  - slash mark (/)  - colon (:)  - asterisk (*)  - question mark (?)  - quotation mark ('')  - less than sign (<)  - greater than sign (>)  - vertical bar (|)as defined by the Microsoft naming convention (see https://support.microsoft.com/en-us/help/909264/)",
    },
    workgroup:          {
      type:      "Optional[String[1,15]]",
      desc:      "Applies to standalone SMB servers only.Windows network workgroup for the SMB server.Workgroup names are limited to 15 alphanumeric ASCII characters.",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
