require 'puppet/resource_api'

# rubocop:disable Layout/EmptyLinesAroundClassBody

# class Puppet::Provider::PowerstoreNasServer::PowerstoreNasServer
class Puppet::Provider::PowerstoreNasServer::PowerstoreNasServer
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
    nas_server = {}
    nas_server['current_unix_directory_service'] = resource[:current_unix_directory_service] unless resource[:current_unix_directory_service].nil?
    nas_server['default_unix_user'] = resource[:default_unix_user] unless resource[:default_unix_user].nil?
    nas_server['default_windows_user'] = resource[:default_windows_user] unless resource[:default_windows_user].nil?
    nas_server['description'] = resource[:description] unless resource[:description].nil?
    nas_server['is_auto_user_mapping_enabled'] = resource[:is_auto_user_mapping_enabled] unless resource[:is_auto_user_mapping_enabled].nil?
    nas_server['is_username_translation_enabled'] = resource[:is_username_translation_enabled] unless resource[:is_username_translation_enabled].nil?
    nas_server['name'] = resource[:name] unless resource[:name].nil?
    nas_server
  end
  def build_update_hash(resource)
    nas_server = {}
    nas_server['backup_IPv4_interface_id'] = resource[:backup_i_pv4_interface_id] unless resource[:backup_i_pv4_interface_id].nil?
    nas_server['backup_IPv6_interface_id'] = resource[:backup_i_pv6_interface_id] unless resource[:backup_i_pv6_interface_id].nil?
    nas_server['current_node_id'] = resource[:current_node_id] unless resource[:current_node_id].nil?
    nas_server['current_unix_directory_service'] = resource[:current_unix_directory_service] unless resource[:current_unix_directory_service].nil?
    nas_server['default_unix_user'] = resource[:default_unix_user] unless resource[:default_unix_user].nil?
    nas_server['default_windows_user'] = resource[:default_windows_user] unless resource[:default_windows_user].nil?
    nas_server['description'] = resource[:description] unless resource[:description].nil?
    nas_server['is_auto_user_mapping_enabled'] = resource[:is_auto_user_mapping_enabled] unless resource[:is_auto_user_mapping_enabled].nil?
    nas_server['is_username_translation_enabled'] = resource[:is_username_translation_enabled] unless resource[:is_username_translation_enabled].nil?
    nas_server['name'] = resource[:name] unless resource[:name].nil?
    nas_server['preferred_node_id'] = resource[:preferred_node_id] unless resource[:preferred_node_id].nil?
    nas_server['production_IPv4_interface_id'] = resource[:production_i_pv4_interface_id] unless resource[:production_i_pv4_interface_id].nil?
    nas_server['production_IPv6_interface_id'] = resource[:production_i_pv6_interface_id] unless resource[:production_i_pv6_interface_id].nil?
    nas_server
  end
  def build_delete_hash(resource)
    nas_server = {}
    nas_server['domain_password'] = resource[:domain_password] unless resource[:domain_password].nil?
    nas_server['domain_user_name'] = resource[:domain_user_name] unless resource[:domain_user_name].nil?
    nas_server['is_skip_domain_unjoin'] = resource[:is_skip_domain_unjoin] unless resource[:is_skip_domain_unjoin].nil?
    nas_server
  end

  def build_hash(resource)
    nas_server = {}
    nas_server['backup_IPv4_interface_id'] = resource[:backup_i_pv4_interface_id] unless resource[:backup_i_pv4_interface_id].nil?
    nas_server['backup_IPv6_interface_id'] = resource[:backup_i_pv6_interface_id] unless resource[:backup_i_pv6_interface_id].nil?
    nas_server['current_node_id'] = resource[:current_node_id] unless resource[:current_node_id].nil?
    nas_server['current_preferred_IPv4_interface_id'] = resource[:current_preferred_i_pv4_interface_id] unless resource[:current_preferred_i_pv4_interface_id].nil?
    nas_server['current_preferred_IPv6_interface_id'] = resource[:current_preferred_i_pv6_interface_id] unless resource[:current_preferred_i_pv6_interface_id].nil?
    nas_server['current_unix_directory_service'] = resource[:current_unix_directory_service] unless resource[:current_unix_directory_service].nil?
    nas_server['current_unix_directory_service_l10n'] = resource[:current_unix_directory_service_l10n] unless resource[:current_unix_directory_service_l10n].nil?
    nas_server['default_unix_user'] = resource[:default_unix_user] unless resource[:default_unix_user].nil?
    nas_server['default_windows_user'] = resource[:default_windows_user] unless resource[:default_windows_user].nil?
    nas_server['description'] = resource[:description] unless resource[:description].nil?
    nas_server['domain_password'] = resource[:domain_password] unless resource[:domain_password].nil?
    nas_server['domain_user_name'] = resource[:domain_user_name] unless resource[:domain_user_name].nil?
    nas_server['id'] = resource[:id] unless resource[:id].nil?
    nas_server['is_auto_user_mapping_enabled'] = resource[:is_auto_user_mapping_enabled] unless resource[:is_auto_user_mapping_enabled].nil?
    nas_server['is_skip_domain_unjoin'] = resource[:is_skip_domain_unjoin] unless resource[:is_skip_domain_unjoin].nil?
    nas_server['is_username_translation_enabled'] = resource[:is_username_translation_enabled] unless resource[:is_username_translation_enabled].nil?
    nas_server['name'] = resource[:name] unless resource[:name].nil?
    nas_server['operational_status'] = resource[:operational_status] unless resource[:operational_status].nil?
    nas_server['operational_status_l10n'] = resource[:operational_status_l10n] unless resource[:operational_status_l10n].nil?
    nas_server['preferred_node_id'] = resource[:preferred_node_id] unless resource[:preferred_node_id].nil?
    nas_server['production_IPv4_interface_id'] = resource[:production_i_pv4_interface_id] unless resource[:production_i_pv4_interface_id].nil?
    nas_server['production_IPv6_interface_id'] = resource[:production_i_pv6_interface_id] unless resource[:production_i_pv6_interface_id].nil?
    nas_server
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
    Puppet.info('Calling operation nas_server_collection_query')
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/nas_server', 'Get', 'application/json')
  end


  def self.invoke_create(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation nas_server_create')
    path_params = {}
    query_params = {}
    header_params = {}
    header_params['User-Agent'] = ''

    op_params = [
      op_param('current_unix_directory_service', 'body', 'current_unix_directory_service', 'current_unix_directory_service'),
      op_param('default_unix_user', 'body', 'default_unix_user', 'default_unix_user'),
      op_param('default_windows_user', 'body', 'default_windows_user', 'default_windows_user'),
      op_param('description', 'body', 'description', 'description'),
      op_param('is_auto_user_mapping_enabled', 'body', 'is_auto_user_mapping_enabled', 'is_auto_user_mapping_enabled'),
      op_param('is_username_translation_enabled', 'body', 'is_username_translation_enabled', 'is_username_translation_enabled'),
      op_param('name', 'body', 'name', 'name'),
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/nas_server', 'Post', 'application/json')
  end


  def self.invoke_update(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation nas_server_modify')
    path_params = {}
    query_params = {}
    header_params = {}
    header_params['User-Agent'] = ''

    op_params = [
      op_param('backup_IPv4_interface_id', 'body', 'backup_i_pv4_interface_id', 'backup_i_pv4_interface_id'),
      op_param('backup_IPv6_interface_id', 'body', 'backup_i_pv6_interface_id', 'backup_i_pv6_interface_id'),
      op_param('current_node_id', 'body', 'current_node_id', 'current_node_id'),
      op_param('current_unix_directory_service', 'body', 'current_unix_directory_service', 'current_unix_directory_service'),
      op_param('default_unix_user', 'body', 'default_unix_user', 'default_unix_user'),
      op_param('default_windows_user', 'body', 'default_windows_user', 'default_windows_user'),
      op_param('description', 'body', 'description', 'description'),
      op_param('id', 'path', 'id', 'id'),
      op_param('is_auto_user_mapping_enabled', 'body', 'is_auto_user_mapping_enabled', 'is_auto_user_mapping_enabled'),
      op_param('is_username_translation_enabled', 'body', 'is_username_translation_enabled', 'is_username_translation_enabled'),
      op_param('name', 'body', 'name', 'name'),
      op_param('preferred_node_id', 'body', 'preferred_node_id', 'preferred_node_id'),
      op_param('production_IPv4_interface_id', 'body', 'production_i_pv4_interface_id', 'production_i_pv4_interface_id'),
      op_param('production_IPv6_interface_id', 'body', 'production_i_pv6_interface_id', 'production_i_pv6_interface_id'),
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/nas_server/%{id}', 'Patch', 'application/json')
  end


  def self.invoke_delete(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation nas_server_delete')
    path_params = {}
    query_params = {}
    header_params = {}
    header_params['User-Agent'] = ''

    op_params = [
      op_param('domain_password', 'body', 'domain_password', 'domain_password'),
      op_param('domain_user_name', 'body', 'domain_user_name', 'domain_user_name'),
      op_param('id', 'path', 'id', 'id'),
      op_param('is_skip_domain_unjoin', 'body', 'is_skip_domain_unjoin', 'is_skip_domain_unjoin'),
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/nas_server/%{id}', 'Delete', 'application/json')
  end




  def self.invoke_get_one(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation nas_server_instance_query')
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/nas_server/%{id}', 'Get', 'application/json')
  end


  def self.fetch_all_as_hash(context)
    items = fetch_all(context)
    if items
      items.map { |item|
        hash = {
          backup_i_pv4_interface_id: item['backup_IPv4_interface_id'],
          backup_i_pv6_interface_id: item['backup_IPv6_interface_id'],
          current_node_id: item['current_node_id'],
          current_preferred_i_pv4_interface_id: item['current_preferred_IPv4_interface_id'],
          current_preferred_i_pv6_interface_id: item['current_preferred_IPv6_interface_id'],
          current_unix_directory_service: item['current_unix_directory_service'],
          current_unix_directory_service_l10n: item['current_unix_directory_service_l10n'],
          default_unix_user: item['default_unix_user'],
          default_windows_user: item['default_windows_user'],
          description: item['description'],
          domain_password: item['domain_password'],
          domain_user_name: item['domain_user_name'],
          id: item['id'],
          is_auto_user_mapping_enabled: item['is_auto_user_mapping_enabled'],
          is_skip_domain_unjoin: item['is_skip_domain_unjoin'],
          is_username_translation_enabled: item['is_username_translation_enabled'],
          name: item['name'],
          operational_status: item['operational_status'],
          operational_status_l10n: item['operational_status_l10n'],
          preferred_node_id: item['preferred_node_id'],
          production_i_pv4_interface_id: item['production_IPv4_interface_id'],
          production_i_pv6_interface_id: item['production_IPv6_interface_id'],
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
