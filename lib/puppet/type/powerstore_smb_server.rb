require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_smb_server',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    computer_name:          {
      type:      'Optional[String]',
      desc:      "DNS Name of the associated Computer Account when the SMB server is joined to an Active Directory domain.This name is limited to 63 bytes and must not contain the following characters -  - comma (.)  - tilde (~)  - colon (:)  - exclamation point (!)  - at sign (@)  - number sign (#)  - dollar sign ($)  - percent (%)  - caret (^)  - ampersand (&)  - apostrophe (')  - period (.) - note that if you enter string with period only the first word will be kept  - parentheses (())  - braces ({})  - underscore (_)  - white space (blank)as defined by the Microsoft naming convention (see https://support.microsoft.com/en-us/help/909264/)",
      behaviour: :init_only,
    },
    description:          {
      type:      'Optional[String]',
      desc:      "Description of the SMB server in UTF-8 characters.",
      behaviour: :init_only,
    },
    domain:          {
      type:      'Optional[String]',
      desc:      "Domain name where SMB server is registered in Active Directory, if applicable.",
      behaviour: :init_only,
    },
    id:          {
      type:      'String',
      desc:      "Unique identifier of the SMB server.",
      behaviour: :namevar,
    },
    is_standalone:          {
      type:      'Optional[Boolean]',
      desc:      "Indicates whether the SMB server is standalone. Values are:- true - SMB server is standalone.- false - SMB server is joined to the Active Directory.",
      behaviour: :init_only,
    },
    local_admin_password:          {
      type:      'Optional[String]',
      desc:      "Password for the local administrator account of the SMB server.",
      behaviour: :init_only,
    },
    nas_server_id:          {
      type:      'String',
      desc:      "Unique identifier of the NAS server.",
      behaviour: :init_only,
    },
    netbios_name:          {
      type:      'Optional[String]',
      desc:      "NetBIOS name is the network name of the standalone SMB server.SMB servers joined to Active Directory also have NetBIOS Name, defaulted to the 15 first characters of the computer_name attribute.Administrators can specify a custom NetBIOS Name for an SMB server using this attribute.NetBIOS name is limited to 15 characters and cannot contain the following characters -  - backslash (\)  - slash mark (/)  - colon (:)  - asterisk (*)  - question mark (?)  - quotation mark ('')  - less than sign (<)  - greater than sign (>)  - vertical bar (|)as defined by the Microsoft naming convention (see https://support.microsoft.com/en-us/help/909264/)",
      behaviour: :init_only,
    },
    workgroup:          {
      type:      'Optional[String]',
      desc:      "Applies to standalone SMB servers only.Windows network workgroup for the SMB server.Workgroup names are limited to 15 alphanumeric ASCII characters.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
