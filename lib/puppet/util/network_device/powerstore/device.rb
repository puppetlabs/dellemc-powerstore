require 'puppet'
require 'puppet/resource_api/transport/wrapper'
# force registering the transport schema
require 'puppet/transport/schema/powerstore'

module Puppet::Util::NetworkDevice::Powerstore
  class Device < Puppet::ResourceApi::Transport::Wrapper
    def initialize(url_or_config, _options = {})
      super('powerstore', url_or_config)
    end
  end
end
