require 'puppet/resource_api'
require "pry"

class Puppet::Provider::PowerstoreVolumeGroup::PowerstoreVolumeGroup
  def canonicalize(context, resources)
    #nout to do here but seems we need to implement it
    resources
  end

  def get(context)
context.debug("Entered get")
      hash = self.class.fetch_all_as_hash(context)
      context.debug("Completed get, returning hash #{hash}")
      hash

  end

  def set(context, changes, noop: false)
    context.debug("Entered set")


    changes.each do |name, change|
      context.debug("set change with #{name} and #{change}")
      #FIXME: key[:name] below hardwires the unique key of the resource to be :name
      is = change.key?(:is) ? change[:is] : get(context).find { |key| key[:name] == name }
      should = change[:should]

      is = { name: name, ensure: 'absent' } if is.nil?
      should = { name: name, ensure: 'absent' } if should.nil?

      if is[:ensure].to_s == 'absent' && should[:ensure].to_s == 'present'
        create(context, name, should) unless noop
      elsif is[:ensure].to_s == 'present' && should[:ensure].to_s == 'absent'
        context.deleting(name) do
          # FIXME hardwired
          should[:id] = is[:id]
          delete(context, should) unless noop
        end
      elsif is[:ensure].to_s == 'absent' && should[:ensure].to_s == 'absent'
        context.failed(name, message: 'Unexpected absent to absent change')
      elsif is[:ensure].to_s == 'present' && should[:ensure].to_s == 'present'
          # FIXME hardwired
          should[:id] = is[:id]
        update(context, name, should)
      end
    end
  end

  def create(context, name, should)
    context.creating(name) do
      new_hash = build_create_hash(should)
      new_hash.delete("id")
      response = self.class.invoke_create(context, should, new_hash)

      if response.is_a? Net::HTTPSuccess
        should[:ensure] = 'present'
        Puppet.info("Added :ensure to property hash")
      else
        raise("Create failed.  Response is #{response} and body is #{response.body}")
      end
    end
  rescue Exception => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end

  def update(context, name, should)
    context.updating(name) do
      new_hash = build_update_hash(should)
      new_hash.delete("id")
      response = self.class.invoke_update(context, should, new_hash)

      if response.is_a? Net::HTTPSuccess
        should[:ensure] = 'present'
        Puppet.info("Added :ensure to property hash")
      else
        raise("Flush failed.  The state of the resource is unknown.  Response is #{response} and body is #{response.body}")
      end
    end
  rescue Exception => ex
    Puppet.alert("Exception during flush. ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end

  def build_create_hash(resource)
    volume_group = {}
    volume_group["description"] = resource[:description] unless resource[:description].nil?
    volume_group["is_write_order_consistent"] = resource[:is_write_order_consistent] unless resource[:is_write_order_consistent].nil?
    volume_group["name"] = resource[:name] unless resource[:name].nil?
    volume_group["protection_policy_id"] = resource[:protection_policy_id] unless resource[:protection_policy_id].nil?
    volume_group["volume_ids"] = resource[:volume_ids] unless resource[:volume_ids].nil?
    return volume_group
  end

  def build_update_hash(resource)
    volume_group = {}
    volume_group["description"] = resource[:description] unless resource[:description].nil?
    volume_group["force"] = resource[:force] unless resource[:force].nil?
    volume_group["is_replication_destination"] = resource[:is_replication_destination] unless resource[:is_replication_destination].nil?
    volume_group["is_write_order_consistent"] = resource[:is_write_order_consistent] unless resource[:is_write_order_consistent].nil?
    volume_group["name"] = resource[:name] unless resource[:name].nil?
    volume_group["protection_policy_id"] = resource[:protection_policy_id] unless resource[:protection_policy_id].nil?
    return volume_group
  end

  def build_delete_hash(resource)
    volume_group = {}
    volume_group["delete_members"] = resource[:delete_members] unless resource[:delete_members].nil?
    return volume_group
  end

  def build_hash(resource)
    volume_group = {}
    volume_group["creation_timestamp"] = resource[:creation_timestamp] unless resource[:creation_timestamp].nil?
    volume_group["delete_members"] = resource[:delete_members] unless resource[:delete_members].nil?
    volume_group["description"] = resource[:description] unless resource[:description].nil?
    volume_group["force"] = resource[:force] unless resource[:force].nil?
    volume_group["id"] = resource[:id] unless resource[:id].nil?
    volume_group["is_importing"] = resource[:is_importing] unless resource[:is_importing].nil?
    volume_group["is_protectable"] = resource[:is_protectable] unless resource[:is_protectable].nil?
    volume_group["is_replication_destination"] = resource[:is_replication_destination] unless resource[:is_replication_destination].nil?
    volume_group["is_write_order_consistent"] = resource[:is_write_order_consistent] unless resource[:is_write_order_consistent].nil?
    volume_group["location_history"] = resource[:location_history] unless resource[:location_history].nil?
    volume_group["migration_session_id"] = resource[:migration_session_id] unless resource[:migration_session_id].nil?
    volume_group["name"] = resource[:name] unless resource[:name].nil?
    volume_group["placement_rule"] = resource[:placement_rule] unless resource[:placement_rule].nil?
    volume_group["protection_data"] = resource[:protection_data] unless resource[:protection_data].nil?
    volume_group["protection_policy_id"] = resource[:protection_policy_id] unless resource[:protection_policy_id].nil?
    volume_group["type"] = resource[:type] unless resource[:type].nil?
    volume_group["type_l10n"] = resource[:type_l10n] unless resource[:type_l10n].nil?
    volume_group["volume_ids"] = resource[:volume_ids] unless resource[:volume_ids].nil?
    return volume_group
  end

  def self.build_key_values
    key_values = {}
    
    key_values["api-version"] = "assets"
    key_values
  end

  # def destroy(context)
  #   delete(context, resource)
  # end

  def delete(context, should)
    new_hash = build_delete_hash(should)
    response = self.class.invoke_delete(context, should, new_hash)
    if response.is_a? Net::HTTPSuccess
      should[:ensure] = 'absent'
      Puppet.info "Added 'absent' to property_hash"
    else
      raise("Delete failed.  The state of the resource is unknown.  Response is #{response} and body is #{response.body}")
    end
  rescue Exception => ex
    Puppet.alert("Exception during destroy. ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def self.invoke_list_all(context, resource = nil, body_params = nil)
    key_values = self.build_key_values
    Puppet.info("Calling operation volume_group_collection_query")
    path_params = {}
    query_params = {}
    header_params = {}
    header_params["User-Agent"] = ""
    
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/volume_group', 'Get','application/json')
  end


  def self.invoke_create(context, resource = nil, body_params = nil)
    key_values = self.build_key_values
    Puppet.info("Calling operation volume_group_create")
    path_params = {}
    query_params = {}
    header_params = {}
    header_params["User-Agent"] = ""
    
    op_params = [
      self.op_param('description', 'body', 'description', 'description'),
      self.op_param('is_write_order_consistent', 'body', 'is_write_order_consistent', 'is_write_order_consistent'),
      self.op_param('name', 'body', 'name', 'name'),
      self.op_param('protection_policy_id', 'body', 'protection_policy_id', 'protection_policy_id'),
      self.op_param('volume_ids', 'body', 'volume_ids', 'volume_ids'),
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/volume_group', 'Post','application/json')
  end


  def self.invoke_update(context, resource = nil, body_params = nil)
    key_values = self.build_key_values
    Puppet.info("Calling operation volume_group_modify")
    path_params = {}
    query_params = {}
    header_params = {}
    header_params["User-Agent"] = ""
    
    op_params = [
      self.op_param('description', 'body', 'description', 'description'),
      self.op_param('force', 'body', 'force', 'force'),
      self.op_param('id', 'path', 'id', 'id'),
      self.op_param('is_replication_destination', 'body', 'is_replication_destination', 'is_replication_destination'),
      self.op_param('is_write_order_consistent', 'body', 'is_write_order_consistent', 'is_write_order_consistent'),
      self.op_param('name', 'body', 'name', 'name'),
      self.op_param('protection_policy_id', 'body', 'protection_policy_id', 'protection_policy_id'),
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/volume_group/%{id}', 'Patch','application/json')
  end


  def self.invoke_delete(context, resource = nil, body_params = nil)
    key_values = self.build_key_values
    Puppet.info("Calling operation volume_group_delete")
    path_params = {}
    query_params = {}
    header_params = {}
    header_params["User-Agent"] = ""
    
    op_params = [
      self.op_param('delete_members', 'body', 'delete_members', 'delete_members'),
      self.op_param('id', 'path', 'id', 'id'),
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/volume_group/%{id}', 'Delete','application/json')
  end




  def self.invoke_get_one(context, resource = nil, body_params = nil)
    key_values = self.build_key_values
    Puppet.info("Calling operation volume_group_instance_query")
    path_params = {}
    query_params = {}
    header_params = {}
    header_params["User-Agent"] = ""
    
    op_params = [
      self.op_param('id', 'path', 'id', 'id'),
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/volume_group/%{id}', 'Get','application/json')
  end


  def self.fetch_all_as_hash(context)
    items = self.fetch_all(context)
    if items
      items.collect do |item|
        hash = {


          creation_timestamp: item['creation_timestamp'],
          delete_members: item['delete_members'],
          description: item['description'],
          force: item['force'],
          id: item['id'],
          is_importing: item['is_importing'],
          is_protectable: item['is_protectable'],
          is_replication_destination: item['is_replication_destination'],
          is_write_order_consistent: item['is_write_order_consistent'],
          location_history: item['location_history'],
          migration_session_id: item['migration_session_id'],
          name: item['name'],
          placement_rule: item['placement_rule'],
          protection_data: item['protection_data'],
          protection_policy_id: item['protection_policy_id'],
          type: item['type'],
          type_l10n: item['type_l10n'],
          volume_ids: item['volume_ids'],
          ensure: 'present',
        }

        Puppet.debug("Adding to collection: #{item}")

        hash

      end.compact
    else
      []
    end
  rescue Exception => ex
    Puppet.alert("ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end

  def self.deep_delete(hash_item, tokens)
    if tokens.size == 1
      if hash_item.kind_of?(Array)
        hash_item.map! { |item| deep_delete(item, tokens) }
      else
        hash_item.delete(tokens[0]) unless hash_item.nil? or hash_item[tokens[0]].nil?
      end
    else
      if hash_item.kind_of?(Array)
        hash_item.map! { |item| deep_delete(item, tokens[1..-1]) }
      else
        hash_item[tokens.first] = deep_delete(hash_item[tokens.first], tokens[1..-1]) unless hash_item.nil? or hash_item[tokens[0]].nil?
      end
    end
    return hash_item
  end

  def self.fetch_all(context)
    response = invoke_list_all(context)
    if response.kind_of? Net::HTTPSuccess
      body = JSON.parse(response.body)
      if body.is_a? Array # and body.key? "value"
        return body #["value"]
      end
    end
  end


  def self.authenticate(path_params, query_params, header_params, body_params)
    return true
  end


  def exists?
    return_value = @property_hash[:ensure] && @property_hash[:ensure] != 'absent'
    Puppet.info("Checking if resource #{name} of type <no value> exists, returning #{return_value}")
    return_value
  end

  def self.add_keys_to_request(request, hash)
    if hash
      hash.each { |x, v| request[x] = v }
    end
  end

  def self.to_query(hash)
    if hash
      return_value = hash.map { |x, v| "#{x}=#{v}" }.reduce { |x, v| "#{x}&#{v}" }
      if !return_value.nil?
        return return_value
      end
    end
    return ""
  end

  def self.op_param(name, inquery, paramalias, namesnake)
    operation_param = { :name => name, :inquery => inquery, :paramalias => paramalias, :namesnake => namesnake }
    return operation_param
  end


end
