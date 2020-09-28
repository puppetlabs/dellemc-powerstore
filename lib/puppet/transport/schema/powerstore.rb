require 'puppet/resource_api'

Puppet::ResourceApi.register_transport(
  name: 'powerstore', # points at class Puppet::Transport::DeviceType
  desc: 'Connects to a powerstore device',
  connection_info: {
    host: {
      type: 'String',
      desc: 'The host to connect to.',
    },
    user: {
      type: 'String',
      desc: 'The user.',
    },
    password: {
      type: 'String',
      sensitive: true,
      desc: 'The password to connect.',
    },
    port: {
      type: 'Optional[Integer]',
      desc: 'The port to connect to, defaults to 443.',
    },
    schema: {
      type: 'Optional[Enum[http,https]]',
      desc: 'The protocol schema to connect over, defaults to https.',
    },
    base_path: {
      type: 'Optional[String]',
      desc: 'The BasePath value that API requests should be sent to, defaults to /api/rest',
    },
    auth: {
      type: 'Optional[Enum[none]]',
      desc: 'Whether or not to authenticate.',
    },
  },
)
