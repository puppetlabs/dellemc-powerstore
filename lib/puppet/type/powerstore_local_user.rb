require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_local_user',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    current_password:          {
      type:      'Optional[String]',
      desc:      "Current password of the local user. Any local user can change his own password by providing current_password along with the new password.",
      behaviour: :init_only,
    },
    id:          {
      type:      'String',
      desc:      "Unique identifier of the local user account.",
      behaviour: :init_only,
    },
    is_locked:          {
      type:      'Optional[Boolean]',
      desc:      "Lock or unlock the local user account. Local user with administration/security administration role can lock or unlock any other local user account. You cannot lock an account you are currently logged-in to.",
      behaviour: :init_only,
    },
    name:          {
      type:      'String',
      desc:      "Name of the new local user account to be created. The name value can be 1 to 64 UTF-8 characters long, and may only use alphanumeric characters. Dot(.) is the only special character allowed.",
      behaviour: :namevar,
    },
    password:          {
      type:      'Optional[String]',
      desc:      "New password of the local user. Local user with administrator or security administrator role can reset the password of other local user accounts without providing the current password. You cannot reset the password of the account you are currently logged-in to.",
      behaviour: :init_only,
    },
    role_id:          {
      type:      'Optional[String]',
      desc:      "The unique identifier of the new role to which the local user has to be mapped. Where role_id '1' is for Administrator, '2' is for Storage Administrator, '3' is for Operator, '4' is for VM Administrator and '5' is for Security Administrator. A local user with either an administration or a security administration role can change the role of any other local user. You cannot change the role of the account you are currently logged-in to.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
