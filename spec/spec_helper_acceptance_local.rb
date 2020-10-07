require 'puppet/resource_api'
require 'date'

# frozen_string_literal: true

COMMON_ARGS = '--modulepath spec/fixtures/modules --deviceconfig spec/fixtures/acceptance-device.conf --target sut'.freeze

def make_site_pp(pp)
  @file = Tempfile.new('site.pp')
  @file.write(pp)
  @file.close
end

def run_device(options = { allow_changes: true, allow_warnings: false, allow_errors: false })
  command = "bundle exec puppet device --apply #{@file.path} #{COMMON_ARGS} --verbose --trace --debug"
  # puts "run_device: ", command

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
  # puts "run_resource: ", command
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

def sample_attr_value(name, attr)
  type = parse_type(name, attr[:type])
  if name =~ /timestamp/
    DateTime.now().iso8601
  else
    sample_value(type)
  end
end

def sample_resource(type_name, options = {ensure: :present, namevars_value: nil})
  attrs = type_attrs(type_name)
  result = attrs.map { |k,v| [k, sample_attr_value(k,v)] }.to_h
  result[:ensure] = options[:ensure]
  namevars(attrs).each { |nv| result[nv] = options[:namevars_value] } if options[:namevars_value]
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
    min_length = type.size_type.from if !type.size_type.nil? and !type.size_type.from.nil? 
    max_length = type.size_type.to if !type.size_type.nil? and !type.size_type.to.nil? 
    length = (!min_length or min_length < 8) ? 8 : min_length
    length = max_length if max_length and length > max_length
    return length.times.map { [*'0'..'9', *'a'..'z', *'A'..'Z'].sample }.join
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

  mode = ENV['MOCK_ACCEPTANCE'] ? 'mock' : 'device'

  c.filter_run_excluding(update: true) unless mode == 'device'

  device = {
    'user'     => ENV['DEVICE_USER'] || 'admin',
    'password' => ENV['DEVICE_PASSWORD'] || 'Dell!2020',
    'host'     => ENV['DEVICE_IP'] || '10.119.0.150'
  }

  mock = {
    'port'      => 4010,
    'host'      => '127.0.0.1',
    'user'      => 'admin',
    'password'  => 'admin',
    'schema'    => 'http',
    'base_path' => ''
  }

  FileUtils.mkdir_p('spec/fixtures/modules') unless Dir.exist?('spec/fixtures/modules')
  FileUtils.ln_sf("#{Dir.getwd}", "#{Dir.getwd}/spec/fixtures/modules/powerstore")

  if mode == 'device'
    if device['user'].empty? || device['password'].empty? || device['host'].empty?
      puts "To test a real device, export environment variables DEVICE_USER, DEVICE_PASSWORD, DEVICE_IP!"
      exit 1
    else
      sut = device
    end
  else
    sut = mock
  end

  File.open('spec/fixtures/sut.json', 'w') do |file|
    file.puts JSON.generate(sut)
  end

  File.open('spec/fixtures/acceptance-device.conf', 'w') do |file|
    file.puts <<DEVICE
[sut]
type powerstore
url file://#{Dir.getwd}/spec/fixtures/sut.json
DEVICE
  end
end
