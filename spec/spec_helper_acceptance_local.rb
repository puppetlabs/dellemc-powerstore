require 'puppet/resource_api'
# frozen_string_literal: true

# device_user = ENV['DEVICE_USER']
# device_password = ENV['DEVICE_PASSWORD']

# if device_ip.nil? || device_user.nil? || device_password.nil? || device_ip.empty? || device_user.empty? || device_password.empty?
#   warning = <<-EOS
#   DEVICE_IP DEVICE_USER DEVICE_PASSWORD environment variables need to be set eg:
#   export DEVICE_IP=1.1.1.1
#   export DEVICE_USER=admin
#   export DEVICE_PASSWORD=password
#   export DEVICE_ENABLE_PASSWORD=password
#   EOS
#   abort warning
# end

COMMON_ARGS = '--modulepath spec/fixtures/modules --deviceconfig spec/fixtures/acceptance-device.conf --target prism'.freeze

def make_site_pp(pp)
  @file = Tempfile.new('site.pp')
  @file.write(pp)
  @file.close
end

def run_device(options = { allow_changes: true, allow_warnings: false, allow_errors: false })
  command = "bundle exec puppet device --apply #{@file.path} #{COMMON_ARGS} --verbose --trace --debug"
  puts "run_device: ", command

  output, _status = Open3.capture2e("bundle exec puppet device --apply #{@file.path} #{COMMON_ARGS} --verbose --trace --debug")

  unless options[:allow_changes]
    expect(output).not_to match(%r{^(\e.*?m)?Notice: /Stage\[main\]})
  end

  unless options[:allow_errors]
    expect(output).not_to match %r{^(\e.*?m)?Error:}
  end

  unless options[:allow_warnings]
    expect(output).not_to match %r{^(\e.*?m)?Warning:}
  end

  output
end

def run_resource(resource_type, resource_title = nil, verbose = true)
  verbose_args = verbose ? '--verbose --trace --debug' : ''
  command = "bundle exec puppet device --resource #{resource_type} #{resource_title} #{COMMON_ARGS} #{verbose_args}"
  puts "run_resource: ", command
  output, _status = Open3.capture2e(command)
  output
end

def namevars(attrs)
  attrs.select { |_name, options|
    options.key?(:behaviour) && options[:behaviour] == :namevar
  }.keys
end

def type_attrs(type_name)
  Puppet::Type.type(type_name.to_sym).context.type.attributes
end

def manifest_from_values(type_name, value_hash)
  attrs = type_attrs(type_name)
  resource = Puppet::ResourceApi::ResourceShim.new(value_hash, type_name, namevars(attrs), attrs)
  manifest = resource.to_manifest
  manifest
end

def sample_manifest(type_name)
  value_hash = sample_resource(type_name)
  manifest_from_values(type_name, value_hash)
end

def sample_resource(type_name)
  attrs = type_attrs(type_name)
  result = attrs.map { |k,v| [k, sample_value(parse_type(k, attrs[k][:type]))] }.to_h
  # require 'pry';binding.pry
  result
end

def parse_type(name, type)
  Puppet::ResourceApi::DataTypeHandling.parse_puppet_type(name, type)
end

def sample_value(type)
  # require 'pry';binding.pry
  case type.name
  when "Optional"
    sample_value(type.type)
  when "String"
    # require 'pry';binding.pry
    if !type.size_type.nil? and !type.size_type.from.nil? and type.size_type.from > 10
      return type.size_type.from.times.map { [*'0'..'9', *'a'..'z', *'A'..'Z'].sample }.join
    end
    'SomeString'
  when "Integer"
    if !type.from.nil? and !type.to.nil?
      (type.from + type.to) / 2
    else
      1984
    end
  when "Boolean"
    true
  when "Array"
    [ sample_value(type.element_type), sample_value(type.element_type) ]
  when "Hash"
    { sample_value(type.key_type) => sample_value(type.value_type) }
  when "Struct"
    type.elements.reduce({}) { |retval, el| 
      # require 'pry';binding.pry
      retval[el.name] = sample_value(el.value_type); retval
    }
  when "Enum"
    type.values[0]
  when "Any"
    'AnyValue'
  else
    'UnknownType'
  end
end

RSpec.configure do |c|
  c.filter_run_excluding(bolt: true) unless ENV['GEM_BOLT']

  FileUtils.mkdir('spec/fixtures/modules') unless Dir.exist?('spec/fixtures/modules')
  FileUtils.ln_sf("#{Dir.getwd}", "#{Dir.getwd}/spec/fixtures/modules/powerstore")

  File.open('spec/fixtures/acceptance-device.conf', 'w') do |file|
    file.puts <<DEVICE
[prism]
type powerstore
url file://#{Dir.getwd}/spec/fixtures/prism.conf
DEVICE
  end
end
