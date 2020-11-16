require 'puppet/resource_api'

# rubocop:disable Layout/EmptyLinesAroundClassBody

# class Puppet::Provider::PowerstoreSmbShare::PowerstoreSmbShare
class Puppet::Provider::PowerstoreSmbShare::PowerstoreSmbShare
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
    smb_share = {}
    smb_share['description'] = resource[:description] unless resource[:description].nil?
    smb_share['file_system_id'] = resource[:file_system_id] unless resource[:file_system_id].nil?
    smb_share['is_ABE_enabled'] = resource[:is_abe_enabled] unless resource[:is_abe_enabled].nil?
    smb_share['is_branch_cache_enabled'] = resource[:is_branch_cache_enabled] unless resource[:is_branch_cache_enabled].nil?
    smb_share['is_continuous_availability_enabled'] = resource[:is_continuous_availability_enabled] unless resource[:is_continuous_availability_enabled].nil?
    smb_share['is_encryption_enabled'] = resource[:is_encryption_enabled] unless resource[:is_encryption_enabled].nil?
    smb_share['name'] = resource[:name] unless resource[:name].nil?
    smb_share['offline_availability'] = resource[:offline_availability] unless resource[:offline_availability].nil?
    smb_share['path'] = resource[:path] unless resource[:path].nil?
    smb_share['umask'] = resource[:umask] unless resource[:umask].nil?
    smb_share
  end
  def build_update_hash(resource)
    smb_share = {}
    smb_share['description'] = resource[:description] unless resource[:description].nil?
    smb_share['is_ABE_enabled'] = resource[:is_abe_enabled] unless resource[:is_abe_enabled].nil?
    smb_share['is_branch_cache_enabled'] = resource[:is_branch_cache_enabled] unless resource[:is_branch_cache_enabled].nil?
    smb_share['is_continuous_availability_enabled'] = resource[:is_continuous_availability_enabled] unless resource[:is_continuous_availability_enabled].nil?
    smb_share['is_encryption_enabled'] = resource[:is_encryption_enabled] unless resource[:is_encryption_enabled].nil?
    smb_share['offline_availability'] = resource[:offline_availability] unless resource[:offline_availability].nil?
    smb_share['umask'] = resource[:umask] unless resource[:umask].nil?
    smb_share
  end
  # rubocop:disable Lint/UnusedMethodArgument
  def build_delete_hash(resource)
    smb_share = {}
    smb_share
  end
  # rubocop:enable Lint/UnusedMethodArgument

  def build_hash(resource)
    smb_share = {}
    smb_share['description'] = resource[:description] unless resource[:description].nil?
    smb_share['file_system_id'] = resource[:file_system_id] unless resource[:file_system_id].nil?
    smb_share['id'] = resource[:id] unless resource[:id].nil?
    smb_share['is_ABE_enabled'] = resource[:is_abe_enabled] unless resource[:is_abe_enabled].nil?
    smb_share['is_branch_cache_enabled'] = resource[:is_branch_cache_enabled] unless resource[:is_branch_cache_enabled].nil?
    smb_share['is_continuous_availability_enabled'] = resource[:is_continuous_availability_enabled] unless resource[:is_continuous_availability_enabled].nil?
    smb_share['is_encryption_enabled'] = resource[:is_encryption_enabled] unless resource[:is_encryption_enabled].nil?
    smb_share['name'] = resource[:name] unless resource[:name].nil?
    smb_share['offline_availability'] = resource[:offline_availability] unless resource[:offline_availability].nil?
    smb_share['offline_availability_l10n'] = resource[:offline_availability_l10n] unless resource[:offline_availability_l10n].nil?
    smb_share['path'] = resource[:path] unless resource[:path].nil?
    smb_share['umask'] = resource[:umask] unless resource[:umask].nil?
    smb_share
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
    Puppet.info('Calling operation smb_share_collection_query')
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/smb_share', 'Get', 'application/json')
  end


  def self.invoke_create(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation smb_share_create')
    path_params = {}
    query_params = {}
    header_params = {}
    header_params['User-Agent'] = ''

    op_params = [
      op_param('description', 'body', 'description', 'description'),
      op_param('file_system_id', 'body', 'file_system_id', 'file_system_id'),
      op_param('is_ABE_enabled', 'body', 'is_abe_enabled', 'is_abe_enabled'),
      op_param('is_branch_cache_enabled', 'body', 'is_branch_cache_enabled', 'is_branch_cache_enabled'),
      op_param('is_continuous_availability_enabled', 'body', 'is_continuous_availability_enabled', 'is_continuous_availability_enabled'),
      op_param('is_encryption_enabled', 'body', 'is_encryption_enabled', 'is_encryption_enabled'),
      op_param('name', 'body', 'name', 'name'),
      op_param('offline_availability', 'body', 'offline_availability', 'offline_availability'),
      op_param('path', 'body', 'path', 'path'),
      op_param('umask', 'body', 'umask', 'umask'),
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/smb_share', 'Post', 'application/json')
  end


  def self.invoke_update(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation smb_share_modify')
    path_params = {}
    query_params = {}
    header_params = {}
    header_params['User-Agent'] = ''

    op_params = [
      op_param('description', 'body', 'description', 'description'),
      op_param('id', 'path', 'id', 'id'),
      op_param('is_ABE_enabled', 'body', 'is_abe_enabled', 'is_abe_enabled'),
      op_param('is_branch_cache_enabled', 'body', 'is_branch_cache_enabled', 'is_branch_cache_enabled'),
      op_param('is_continuous_availability_enabled', 'body', 'is_continuous_availability_enabled', 'is_continuous_availability_enabled'),
      op_param('is_encryption_enabled', 'body', 'is_encryption_enabled', 'is_encryption_enabled'),
      op_param('offline_availability', 'body', 'offline_availability', 'offline_availability'),
      op_param('umask', 'body', 'umask', 'umask'),
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/smb_share/%{id}', 'Patch', 'application/json')
  end


  def self.invoke_delete(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation smb_share_delete')
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/smb_share/%{id}', 'Delete', 'application/json')
  end




  def self.invoke_get_one(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation smb_share_instance_query')
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/smb_share/%{id}', 'Get', 'application/json')
  end


  def self.fetch_all_as_hash(context)
    items = fetch_all(context)
    if items
      items.map { |item|
        hash = {
          description: item['description'],
          file_system_id: item['file_system_id'],
          id: item['id'],
          is_abe_enabled: item['is_ABE_enabled'],
          is_branch_cache_enabled: item['is_branch_cache_enabled'],
          is_continuous_availability_enabled: item['is_continuous_availability_enabled'],
          is_encryption_enabled: item['is_encryption_enabled'],
          name: item['name'],
          offline_availability: item['offline_availability'],
          offline_availability_l10n: item['offline_availability_l10n'],
          path: item['path'],
          umask: item['umask'],
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
