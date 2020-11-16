#!/opt/puppetlabs/puppet/bin/ruby

require_relative '../lib/puppet/util/task_helper'
require 'json'
require 'puppet'
require 'openssl'
# require 'pry-remote'; binding.remote_pry

# class PowerstoreBondInstanceQueryTask
class PowerstoreBondInstanceQueryTask < TaskHelper
  def task(arg_hash)
    header_params = {}
    # Remove task name from arguments - should contain all necessary parameters for URI
    arg_hash.delete('_task')
    namevar = ''
    namevar = 'id' if namevar.empty?
    operation_verb = 'Get'
    operation_path = '/bond/%{id}'
    parent_consumes = 'application/json'
    # parent_produces = 'application/json'
    query_params, body_params, path_params = format_params(arg_hash)

    result = transport.call_op(path_params, query_params, header_params, body_params, operation_path, operation_verb, parent_consumes)

    raise result.body unless result.is_a? Net::HTTPSuccess
    return nil if result.body.nil?
    return result.body if result.to_hash['content-type'].include? 'document/text'
    body = JSON.parse(result.body)
    return body.map { |i| [i[namevar], i] }.to_h if body.class == Array
    body
  end

  def op_param(name, location, paramalias, namesnake)
    { name: name, location: location, paramalias: paramalias, namesnake: namesnake }
  end

  def format_params(key_values)
    query_params = {}
    body_params = {}
    path_params = {}

    key_values.each do |key, value|
      next unless value.respond_to?(:include) && value.include?('=>')
      value.include?('=>')
      Puppet.debug("Running hash from string on #{value}")
      value.tr!('=>', ':')
      value.tr!("'", '"')
      key_values[key] = JSON.parse(value)
      Puppet.debug("Obtained hash #{key_values[key].inspect}")
    end

    if key_values.key?('body')
      if File.file?(key_values['body'])
        body_params['file_content'] = if key_values['body'].include?('json')
                                        File.read(key_values['body'])
                                      else
                                        JSON.pretty_generate(YAML.load_file(key_values['body']))
                                      end
      end
    end

    op_params = [
      op_param('id', 'path', 'id', 'id'),
      op_param('query_string', 'query', 'query_string', 'query_string'),
    ]
    op_params.each do |i|
      location = i[:location]
      name     = i[:name]
      # paramalias = i[:paramalias]
      name_snake = i[:namesnake]
      if location == 'query'
        query_params[name] = key_values[name_snake.to_sym] unless key_values[name_snake.to_sym].nil?
      elsif location == 'body'
        body_params[name] = key_values[name_snake.to_sym] unless key_values[name_snake.to_sym].nil?
      else
        path_params[name_snake.to_sym] = key_values[name_snake.to_sym] unless key_values[name_snake.to_sym].nil?
      end
    end

    [query_params, body_params, path_params]
  end

  if $PROGRAM_NAME == __FILE__
    PowerstoreBondInstanceQueryTask.run
  end
end
