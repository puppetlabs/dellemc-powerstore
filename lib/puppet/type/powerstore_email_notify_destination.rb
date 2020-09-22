require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'powerstore_email_notify_destination',
  features: [ 'remote_resource' ],

  desc: <<-EOS,
    
  EOS
  attributes:   {
    ensure:      {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },

    email_address:          {
      type:      'Optional[String]',
      desc:      "Email address to receive notifications.",
      behaviour: :init_only,
    },
    id:          {
      type:      'String',
      desc:      "Unique identifier of the email notification destination.",
      behaviour: :namevar,
    },
    notify_critical:          {
      type:      'Optional[Boolean]',
      desc:      "Whether to send notifications for critical alerts.",
      behaviour: :init_only,
    },
    notify_info:          {
      type:      'Optional[Boolean]',
      desc:      "Whether to send notifications for informational alerts.",
      behaviour: :init_only,
    },
    notify_major:          {
      type:      'Optional[Boolean]',
      desc:      "Whether to send notifications for major alerts.",
      behaviour: :init_only,
    },
    notify_minor:          {
      type:      'Optional[Boolean]',
      desc:      "Whether to send notifications for minor alerts.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
