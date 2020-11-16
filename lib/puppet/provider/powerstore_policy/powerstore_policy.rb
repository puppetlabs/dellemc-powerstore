require 'puppet/resource_api'

# rubocop:disable Layout/EmptyLinesAroundClassBody

# class Puppet::Provider::PowerstorePolicy::PowerstorePolicy
class Puppet::Provider::PowerstorePolicy::PowerstorePolicy
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
    policy = {}
    policy['description'] = resource[:description] unless resource[:description].nil?
    policy['name'] = resource[:name] unless resource[:name].nil?
    policy['replication_rule_ids'] = resource[:replication_rule_ids] unless resource[:replication_rule_ids].nil?
    policy['snapshot_rule_ids'] = resource[:snapshot_rule_ids] unless resource[:snapshot_rule_ids].nil?
    policy
  end
  def build_update_hash(resource)
    policy = {}
    policy['add_replication_rule_ids'] = resource[:add_replication_rule_ids] unless resource[:add_replication_rule_ids].nil?
    policy['add_snapshot_rule_ids'] = resource[:add_snapshot_rule_ids] unless resource[:add_snapshot_rule_ids].nil?
    policy['description'] = resource[:description] unless resource[:description].nil?
    policy['name'] = resource[:name] unless resource[:name].nil?
    policy['remove_replication_rule_ids'] = resource[:remove_replication_rule_ids] unless resource[:remove_replication_rule_ids].nil?
    policy['remove_snapshot_rule_ids'] = resource[:remove_snapshot_rule_ids] unless resource[:remove_snapshot_rule_ids].nil?
    policy['replication_rule_ids'] = resource[:replication_rule_ids] unless resource[:replication_rule_ids].nil?
    policy['snapshot_rule_ids'] = resource[:snapshot_rule_ids] unless resource[:snapshot_rule_ids].nil?
    policy
  end
  # rubocop:disable Lint/UnusedMethodArgument
  def build_delete_hash(resource)
    policy = {}
    policy
  end
  # rubocop:enable Lint/UnusedMethodArgument

  def build_hash(resource)
    policy = {}
    policy['add_replication_rule_ids'] = resource[:add_replication_rule_ids] unless resource[:add_replication_rule_ids].nil?
    policy['add_snapshot_rule_ids'] = resource[:add_snapshot_rule_ids] unless resource[:add_snapshot_rule_ids].nil?
    policy['description'] = resource[:description] unless resource[:description].nil?
    policy['id'] = resource[:id] unless resource[:id].nil?
    policy['is_replica'] = resource[:is_replica] unless resource[:is_replica].nil?
    policy['name'] = resource[:name] unless resource[:name].nil?
    policy['remove_replication_rule_ids'] = resource[:remove_replication_rule_ids] unless resource[:remove_replication_rule_ids].nil?
    policy['remove_snapshot_rule_ids'] = resource[:remove_snapshot_rule_ids] unless resource[:remove_snapshot_rule_ids].nil?
    policy['replication_rule_ids'] = resource[:replication_rule_ids] unless resource[:replication_rule_ids].nil?
    policy['snapshot_rule_ids'] = resource[:snapshot_rule_ids] unless resource[:snapshot_rule_ids].nil?
    policy['type'] = resource[:type] unless resource[:type].nil?
    policy['type_l10n'] = resource[:type_l10n] unless resource[:type_l10n].nil?
    policy
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
    Puppet.info('Calling operation policy_collection_query')
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/policy', 'Get', 'application/json')
  end


  def self.invoke_create(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation policy_create')
    path_params = {}
    query_params = {}
    header_params = {}
    header_params['User-Agent'] = ''

    op_params = [
      op_param('description', 'body', 'description', 'description'),
      op_param('name', 'body', 'name', 'name'),
      op_param('replication_rule_ids', 'body', 'replication_rule_ids', 'replication_rule_ids'),
      op_param('snapshot_rule_ids', 'body', 'snapshot_rule_ids', 'snapshot_rule_ids'),
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/policy', 'Post', 'application/json')
  end


  def self.invoke_update(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation policy_modify')
    path_params = {}
    query_params = {}
    header_params = {}
    header_params['User-Agent'] = ''

    op_params = [
      op_param('add_replication_rule_ids', 'body', 'add_replication_rule_ids', 'add_replication_rule_ids'),
      op_param('add_snapshot_rule_ids', 'body', 'add_snapshot_rule_ids', 'add_snapshot_rule_ids'),
      op_param('description', 'body', 'description', 'description'),
      op_param('id', 'path', 'id', 'id'),
      op_param('name', 'body', 'name', 'name'),
      op_param('remove_replication_rule_ids', 'body', 'remove_replication_rule_ids', 'remove_replication_rule_ids'),
      op_param('remove_snapshot_rule_ids', 'body', 'remove_snapshot_rule_ids', 'remove_snapshot_rule_ids'),
      op_param('replication_rule_ids', 'body', 'replication_rule_ids', 'replication_rule_ids'),
      op_param('snapshot_rule_ids', 'body', 'snapshot_rule_ids', 'snapshot_rule_ids'),
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/policy/%{id}', 'Patch', 'application/json')
  end


  def self.invoke_delete(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation policy_delete')
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/policy/%{id}', 'Delete', 'application/json')
  end




  def self.invoke_get_one(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation policy_instance_query')
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/policy/%{id}', 'Get', 'application/json')
  end


  def self.fetch_all_as_hash(context)
    items = fetch_all(context)
    if items
      items.map { |item|
        hash = {
          add_replication_rule_ids: item['add_replication_rule_ids'],
          add_snapshot_rule_ids: item['add_snapshot_rule_ids'],
          description: item['description'],
          id: item['id'],
          is_replica: item['is_replica'],
          name: item['name'],
          remove_replication_rule_ids: item['remove_replication_rule_ids'],
          remove_snapshot_rule_ids: item['remove_snapshot_rule_ids'],
          replication_rule_ids: item['replication_rule_ids'],
          snapshot_rule_ids: item['snapshot_rule_ids'],
          type: item['type'],
          type_l10n: item['type_l10n'],
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
