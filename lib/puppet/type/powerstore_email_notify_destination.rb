require 'puppet/resource_api'

# rubocop:disable Style/StringLiterals

# Use these resource types to configure outgoing SMTP and email notifications.
Puppet::ResourceApi.register_type(
  name: 'powerstore_email_notify_destination',
  features: ['remote_resource'],
  # rubocop:disable Lint/UnneededDisable
  # rubocop:disable Layout/TrailingWhitespace
  desc: <<-EOS,
    Use these resource types to configure outgoing SMTP and email notifications.
  EOS
  attributes:   {
    ensure:      {
      type:      "Enum['present', 'absent']",
      desc:      'Whether this resource should be present or absent on the target system.',
      default:   'present',
    },
    email_address:          {
      type:      "Optional[String]",
      desc:      "Email address to receive notifications.",
    },
    id:          {
      type:      "String",
      desc:      "Unique identifier of the email notification destination.",
      behaviour: :namevar,
    },
    notify_critical:          {
      type:      "Optional[Boolean]",
      desc:      "Whether to send notifications for critical alerts.",
    },
    notify_info:          {
      type:      "Optional[Boolean]",
      desc:      "Whether send notifications for informational alerts.",
    },
    notify_major:          {
      type:      "Optional[Boolean]",
      desc:      "Whether to send notifications for major alerts.",
    },
    notify_minor:          {
      type:      "Optional[Boolean]",
      desc:      "Whether to send notifications for minor alerts.",
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
