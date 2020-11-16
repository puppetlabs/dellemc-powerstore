require 'puppet/resource_api'

# rubocop:disable Layout/EmptyLinesAroundClassBody

# class Puppet::Provider::PowerstoreRemoteSystem::PowerstoreRemoteSystem
class Puppet::Provider::PowerstoreRemoteSystem::PowerstoreRemoteSystem
  def canonicalize(_context, resources)
    # nout to do here but seems we need to implement it
    resources
  end

  def get(context)
    context.debug('Entered get')
    hash = self.class.fetch_all_as_hash(context)
    context.debug("Completed get, returning hash #{hash}")
    hash
  end

  def set(context, changes, noop: false)
    context.debug('Entered set')

    changes.each do |name, change|
      context.debug("set change with #{name} and #{change}")
      # FIXME: key[:name] below hardwires the unique key of the resource to be :name
      is = change.key?(:is) ? change[:is] : get(context).find { |key| key[:name] == name }
      should = change[:should]

      is = { name: name, ensure: 'absent' } if is.nil?
      should = { name: name, ensure: 'absent' } if should.nil?

      if is[:ensure].to_s == 'absent' && should[:ensure].to_s == 'present'
        create(context, name, should) unless noop
      elsif is[:ensure].to_s == 'present' && should[:ensure].to_s == 'absent'
        context.deleting(name) do
          # FIXME: hardwired
          should[:id] = is[:id]
          delete(context, should) unless noop
        end
      elsif is[:ensure].to_s == 'absent' && should[:ensure].to_s == 'absent'
        context.failed(name, message: 'Unexpected absent to absent change')
      elsif is[:ensure].to_s == 'present' && should[:ensure].to_s == 'present'
        # FIXME: hardwired
        should[:id] = is[:id]
        update(context, name, should)
      end
    end
  end

  def create(context, name, should)
    context.creating(name) do
      new_hash = build_create_hash(should)
      new_hash.delete('id')
      response = self.class.invoke_create(context, should, new_hash)

      raise("Create failed.  Response is #{response} and body is #{response.body}") unless response.is_a? Net::HTTPSuccess
      should[:ensure] = 'present'
      Puppet.info('Added :ensure to property hash')
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end

  def update(context, name, should)
    context.updating(name) do
      new_hash = build_update_hash(should)
      new_hash.delete('id')
      response = self.class.invoke_update(context, should, new_hash)

      raise("Update failed. The state of the resource is unknown.  Response is #{response} and body is #{response.body}") unless response.is_a? Net::HTTPSuccess
      should[:ensure] = 'present'
      Puppet.info('Added :ensure to property hash')
    end
  rescue StandardError => ex
    Puppet.alert("Exception during update. ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end

  def build_create_hash(resource)
    remote_system = {}
    remote_system['data_network_latency'] = resource[:data_network_latency] unless resource[:data_network_latency].nil?
    remote_system['description'] = resource[:description] unless resource[:description].nil?
    remote_system['discovery_chap_mode'] = resource[:discovery_chap_mode] unless resource[:discovery_chap_mode].nil?
    remote_system['import_chap_info'] = resource[:import_chap_info] unless resource[:import_chap_info].nil?
    remote_system['iscsi_addresses'] = resource[:iscsi_addresses] unless resource[:iscsi_addresses].nil?
    remote_system['management_address'] = resource[:management_address] unless resource[:management_address].nil?
    remote_system['name'] = resource[:name] unless resource[:name].nil?
    remote_system['remote_password'] = resource[:remote_password] unless resource[:remote_password].nil?
    remote_system['remote_username'] = resource[:remote_username] unless resource[:remote_username].nil?
    remote_system['session_chap_mode'] = resource[:session_chap_mode] unless resource[:session_chap_mode].nil?
    remote_system['type'] = resource[:type] unless resource[:type].nil?
    remote_system
  end
  def build_update_hash(resource)
    remote_system = {}
    remote_system['data_network_latency'] = resource[:data_network_latency] unless resource[:data_network_latency].nil?
    remote_system['description'] = resource[:description] unless resource[:description].nil?
    remote_system['management_address'] = resource[:management_address] unless resource[:management_address].nil?
    remote_system['name'] = resource[:name] unless resource[:name].nil?
    remote_system['remote_password'] = resource[:remote_password] unless resource[:remote_password].nil?
    remote_system['remote_username'] = resource[:remote_username] unless resource[:remote_username].nil?
    remote_system
  end
  # rubocop:disable Lint/UnusedMethodArgument
  def build_delete_hash(resource)
    remote_system = {}
    remote_system
  end
  # rubocop:enable Lint/UnusedMethodArgument

  def build_hash(resource)
    remote_system = {}
    remote_system['data_connection_state'] = resource[:data_connection_state] unless resource[:data_connection_state].nil?
    remote_system['data_connection_state_l10n'] = resource[:data_connection_state_l10n] unless resource[:data_connection_state_l10n].nil?
    remote_system['data_connections'] = resource[:data_connections] unless resource[:data_connections].nil?
    remote_system['data_network_latency'] = resource[:data_network_latency] unless resource[:data_network_latency].nil?
    remote_system['data_network_latency_l10n'] = resource[:data_network_latency_l10n] unless resource[:data_network_latency_l10n].nil?
    remote_system['description'] = resource[:description] unless resource[:description].nil?
    remote_system['discovery_chap_mode'] = resource[:discovery_chap_mode] unless resource[:discovery_chap_mode].nil?
    remote_system['discovery_chap_mode_l10n'] = resource[:discovery_chap_mode_l10n] unless resource[:discovery_chap_mode_l10n].nil?
    remote_system['id'] = resource[:id] unless resource[:id].nil?
    remote_system['import_chap_info'] = resource[:import_chap_info] unless resource[:import_chap_info].nil?
    remote_system['iscsi_addresses'] = resource[:iscsi_addresses] unless resource[:iscsi_addresses].nil?
    remote_system['management_address'] = resource[:management_address] unless resource[:management_address].nil?
    remote_system['name'] = resource[:name] unless resource[:name].nil?
    remote_system['remote_password'] = resource[:remote_password] unless resource[:remote_password].nil?
    remote_system['remote_username'] = resource[:remote_username] unless resource[:remote_username].nil?
    remote_system['serial_number'] = resource[:serial_number] unless resource[:serial_number].nil?
    remote_system['session_chap_mode'] = resource[:session_chap_mode] unless resource[:session_chap_mode].nil?
    remote_system['session_chap_mode_l10n'] = resource[:session_chap_mode_l10n] unless resource[:session_chap_mode_l10n].nil?
    remote_system['state'] = resource[:state] unless resource[:state].nil?
    remote_system['state_l10n'] = resource[:state_l10n] unless resource[:state_l10n].nil?
    remote_system['type'] = resource[:type] unless resource[:type].nil?
    remote_system['type_l10n'] = resource[:type_l10n] unless resource[:type_l10n].nil?
    remote_system['user_name'] = resource[:user_name] unless resource[:user_name].nil?
    remote_system
  end

  def self.build_key_values
    key_values = {}
    key_values['api-version'] = 'assets'
    key_values
  end

  def delete(context, should)
    new_hash = build_delete_hash(should)
    response = self.class.invoke_delete(context, should, new_hash)
    raise("Delete failed.  The state of the resource is unknown.  Response is #{response} and body is #{response.body}") unless response.is_a? Net::HTTPSuccess
    should[:ensure] = 'absent'
    Puppet.info "Added 'absent' to property_hash"
  rescue StandardError => ex
    Puppet.alert("Exception during destroy. ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def self.invoke_list_all(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation remote_system_collection_query')
    path_params = {}
    query_params = {}
    header_params = {}
    header_params['User-Agent'] = ''

    op_params = [
    ]
    op_params.each do |i|
      inquery = i[:inquery]
      name    = i[:name]
      paramalias = i[:paramalias]
      name_snake = i[:namesnake]
      if inquery == 'query'
        query_params[name] = key_values[name] unless key_values[name].nil?
        query_params[name] = ENV["powerstore_#{name_snake}"] unless ENV["powerstore_#{name_snake}"].nil?
        query_params[name] = resource[paramalias.to_sym] unless resource.nil? || resource[paramalias.to_sym].nil?
      else
        path_params[name_snake.to_sym] = key_values[name] unless key_values[name].nil?
        path_params[name_snake.to_sym] = ENV["powerstore_#{name_snake}"] unless ENV["powerstore_#{name_snake}"].nil?
        path_params[name_snake.to_sym] = resource[paramalias.to_sym] unless resource.nil? || resource[paramalias.to_sym].nil?
      end
    end
    context.transport.call_op(path_params, query_params, header_params, body_params, '/remote_system', 'Get', 'application/json')
  end


  def self.invoke_create(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation remote_system_create')
    path_params = {}
    query_params = {}
    header_params = {}
    header_params['User-Agent'] = ''

    op_params = [
      op_param('data_network_latency', 'body', 'data_network_latency', 'data_network_latency'),
      op_param('description', 'body', 'description', 'description'),
      op_param('discovery_chap_mode', 'body', 'discovery_chap_mode', 'discovery_chap_mode'),
      op_param('import_chap_info', 'body', 'import_chap_info', 'import_chap_info'),
      op_param('iscsi_addresses', 'body', 'iscsi_addresses', 'iscsi_addresses'),
      op_param('management_address', 'body', 'management_address', 'management_address'),
      op_param('name', 'body', 'name', 'name'),
      op_param('remote_password', 'body', 'remote_password', 'remote_password'),
      op_param('remote_username', 'body', 'remote_username', 'remote_username'),
      op_param('session_chap_mode', 'body', 'session_chap_mode', 'session_chap_mode'),
      op_param('type', 'body', 'type', 'type'),
    ]
    op_params.each do |i|
      inquery = i[:inquery]
      name    = i[:name]
      paramalias = i[:paramalias]
      name_snake = i[:namesnake]
      if inquery == 'query'
        query_params[name] = key_values[name] unless key_values[name].nil?
        query_params[name] = ENV["powerstore_#{name_snake}"] unless ENV["powerstore_#{name_snake}"].nil?
        query_params[name] = resource[paramalias.to_sym] unless resource.nil? || resource[paramalias.to_sym].nil?
      else
        path_params[name_snake.to_sym] = key_values[name] unless key_values[name].nil?
        path_params[name_snake.to_sym] = ENV["powerstore_#{name_snake}"] unless ENV["powerstore_#{name_snake}"].nil?
        path_params[name_snake.to_sym] = resource[paramalias.to_sym] unless resource.nil? || resource[paramalias.to_sym].nil?
      end
    end
    context.transport.call_op(path_params, query_params, header_params, body_params, '/remote_system', 'Post', 'application/json')
  end


  def self.invoke_update(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation remote_system_modify')
    path_params = {}
    query_params = {}
    header_params = {}
    header_params['User-Agent'] = ''

    op_params = [
      op_param('data_network_latency', 'body', 'data_network_latency', 'data_network_latency'),
      op_param('description', 'body', 'description', 'description'),
      op_param('id', 'path', 'id', 'id'),
      op_param('management_address', 'body', 'management_address', 'management_address'),
      op_param('name', 'body', 'name', 'name'),
      op_param('remote_password', 'body', 'remote_password', 'remote_password'),
      op_param('remote_username', 'body', 'remote_username', 'remote_username'),
    ]
    op_params.each do |i|
      inquery = i[:inquery]
      name    = i[:name]
      paramalias = i[:paramalias]
      name_snake = i[:namesnake]
      if inquery == 'query'
        query_params[name] = key_values[name] unless key_values[name].nil?
        query_params[name] = ENV["powerstore_#{name_snake}"] unless ENV["powerstore_#{name_snake}"].nil?
        query_params[name] = resource[paramalias.to_sym] unless resource.nil? || resource[paramalias.to_sym].nil?
      else
        path_params[name_snake.to_sym] = key_values[name] unless key_values[name].nil?
        path_params[name_snake.to_sym] = ENV["powerstore_#{name_snake}"] unless ENV["powerstore_#{name_snake}"].nil?
        path_params[name_snake.to_sym] = resource[paramalias.to_sym] unless resource.nil? || resource[paramalias.to_sym].nil?
      end
    end
    context.transport.call_op(path_params, query_params, header_params, body_params, '/remote_system/%{id}', 'Patch', 'application/json')
  end


  def self.invoke_delete(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation remote_system_delete')
    path_params = {}
    query_params = {}
    header_params = {}
    header_params['User-Agent'] = ''

    op_params = [
      op_param('id', 'path', 'id', 'id'),
    ]
    op_params.each do |i|
      inquery = i[:inquery]
      name    = i[:name]
      paramalias = i[:paramalias]
      name_snake = i[:namesnake]
      if inquery == 'query'
        query_params[name] = key_values[name] unless key_values[name].nil?
        query_params[name] = ENV["powerstore_#{name_snake}"] unless ENV["powerstore_#{name_snake}"].nil?
        query_params[name] = resource[paramalias.to_sym] unless resource.nil? || resource[paramalias.to_sym].nil?
      else
        path_params[name_snake.to_sym] = key_values[name] unless key_values[name].nil?
        path_params[name_snake.to_sym] = ENV["powerstore_#{name_snake}"] unless ENV["powerstore_#{name_snake}"].nil?
        path_params[name_snake.to_sym] = resource[paramalias.to_sym] unless resource.nil? || resource[paramalias.to_sym].nil?
      end
    end
    context.transport.call_op(path_params, query_params, header_params, body_params, '/remote_system/%{id}', 'Delete', 'application/json')
  end




  def self.invoke_get_one(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation remote_system_instance_query')
    path_params = {}
    query_params = {}
    header_params = {}
    header_params['User-Agent'] = ''

    op_params = [
      op_param('id', 'path', 'id', 'id'),
    ]
    op_params.each do |i|
      inquery = i[:inquery]
      name    = i[:name]
      paramalias = i[:paramalias]
      name_snake = i[:namesnake]
      if inquery == 'query'
        query_params[name] = key_values[name] unless key_values[name].nil?
        query_params[name] = ENV["powerstore_#{name_snake}"] unless ENV["powerstore_#{name_snake}"].nil?
        query_params[name] = resource[paramalias.to_sym] unless resource.nil? || resource[paramalias.to_sym].nil?
      else
        path_params[name_snake.to_sym] = key_values[name] unless key_values[name].nil?
        path_params[name_snake.to_sym] = ENV["powerstore_#{name_snake}"] unless ENV["powerstore_#{name_snake}"].nil?
        path_params[name_snake.to_sym] = resource[paramalias.to_sym] unless resource.nil? || resource[paramalias.to_sym].nil?
      end
    end
    context.transport.call_op(path_params, query_params, header_params, body_params, '/remote_system/%{id}', 'Get', 'application/json')
  end


  def self.fetch_all_as_hash(context)
    items = fetch_all(context)
    if items
      items.map { |item|
        hash = {
          data_connection_state: item['data_connection_state'],
          data_connection_state_l10n: item['data_connection_state_l10n'],
          data_connections: item['data_connections'],
          data_network_latency: item['data_network_latency'],
          data_network_latency_l10n: item['data_network_latency_l10n'],
          description: item['description'],
          discovery_chap_mode: item['discovery_chap_mode'],
          discovery_chap_mode_l10n: item['discovery_chap_mode_l10n'],
          id: item['id'],
          import_chap_info: item['import_chap_info'],
          iscsi_addresses: item['iscsi_addresses'],
          management_address: item['management_address'],
          name: item['name'],
          remote_password: item['remote_password'],
          remote_username: item['remote_username'],
          serial_number: item['serial_number'],
          session_chap_mode: item['session_chap_mode'],
          session_chap_mode_l10n: item['session_chap_mode_l10n'],
          state: item['state'],
          state_l10n: item['state_l10n'],
          type: item['type'],
          type_l10n: item['type_l10n'],
          user_name: item['user_name'],
          ensure: 'present',
        }
        Puppet.debug("Adding to collection: #{item}")
        hash
      }.compact
    else
      []
    end
  rescue StandardError => ex
    Puppet.alert("ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end

  def self.deep_delete(hash_item, tokens)
    if tokens.size == 1
      if hash_item.is_a?(Array)
        hash_item.map! { |item| deep_delete(item, tokens) }
      else
        hash_item.delete(tokens[0]) unless hash_item.nil? || hash_item[tokens[0]].nil?
      end
    elsif hash_item.is_a?(Array)
      hash_item.map! { |item| deep_delete(item, tokens[1..-1]) }
    else
      hash_item[tokens.first] = deep_delete(hash_item[tokens.first], tokens[1..-1]) unless hash_item.nil? || hash_item[tokens[0]].nil?
    end
    hash_item
  end

  def self.fetch_all(context)
    response = invoke_list_all(context)
    return unless response.is_a? Net::HTTPSuccess
    body = JSON.parse(response.body)
    body # ["value"] if body.is_a? Array # and body.key? "value"
  end

  def self.authenticate(_path_params, _query_params, _header_params, _body_params)
    true
  end


  def exists?
    return_value = @property_hash[:ensure] && @property_hash[:ensure] != 'absent'
    Puppet.info("Checking if resource #{name} of type <no value> exists, returning #{return_value}")
    return_value
  end

  def self.add_keys_to_request(request, hash)
    hash.each { |x, v| request[x] = v } if hash
  end

  def self.to_query(hash)
    if hash
      return_value = hash.map { |x, v| "#{x}=#{v}" }.reduce { |x, v| "#{x}&#{v}" }
      return return_value unless return_value.nil?
    end
    ''
  end

  def self.op_param(name, inquery, paramalias, namesnake)
    { name: name, inquery: inquery, paramalias: paramalias, namesnake: namesnake }
  end


end
