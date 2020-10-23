require 'puppet/resource_api'
require "pry"

class Puppet::Provider::PowerstoreImportHostSystem::PowerstoreImportHostSystem
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
        raise("Update failed. The state of the resource is unknown.  Response is #{response} and body is #{response.body}")
      end
    end
  rescue Exception => ex
    Puppet.alert("Exception during update. ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end

  def build_create_hash(resource)
    import_host_system = {}
    import_host_system["agent_address"] = resource[:agent_address] unless resource[:agent_address].nil?
    import_host_system["agent_port"] = resource[:agent_port] unless resource[:agent_port].nil?
    import_host_system["chap_mutual_password"] = resource[:chap_mutual_password] unless resource[:chap_mutual_password].nil?
    import_host_system["chap_mutual_username"] = resource[:chap_mutual_username] unless resource[:chap_mutual_username].nil?
    import_host_system["chap_single_password"] = resource[:chap_single_password] unless resource[:chap_single_password].nil?
    import_host_system["chap_single_username"] = resource[:chap_single_username] unless resource[:chap_single_username].nil?
    import_host_system["os_type"] = resource[:os_type] unless resource[:os_type].nil?
    import_host_system["password"] = resource[:password] unless resource[:password].nil?
    import_host_system["user_name"] = resource[:user_name] unless resource[:user_name].nil?
    return import_host_system
  end

  def build_update_hash(resource)
    import_host_system = {}
    return import_host_system
  end

  def build_delete_hash(resource)
    import_host_system = {}
    return import_host_system
  end

  def build_hash(resource)
    import_host_system = {}
    import_host_system["agent_address"] = resource[:agent_address] unless resource[:agent_address].nil?
    import_host_system["agent_api_version"] = resource[:agent_api_version] unless resource[:agent_api_version].nil?
    import_host_system["agent_port"] = resource[:agent_port] unless resource[:agent_port].nil?
    import_host_system["agent_status"] = resource[:agent_status] unless resource[:agent_status].nil?
    import_host_system["agent_status_l10n"] = resource[:agent_status_l10n] unless resource[:agent_status_l10n].nil?
    import_host_system["agent_type"] = resource[:agent_type] unless resource[:agent_type].nil?
    import_host_system["agent_type_l10n"] = resource[:agent_type_l10n] unless resource[:agent_type_l10n].nil?
    import_host_system["agent_version"] = resource[:agent_version] unless resource[:agent_version].nil?
    import_host_system["chap_mutual_password"] = resource[:chap_mutual_password] unless resource[:chap_mutual_password].nil?
    import_host_system["chap_mutual_username"] = resource[:chap_mutual_username] unless resource[:chap_mutual_username].nil?
    import_host_system["chap_single_password"] = resource[:chap_single_password] unless resource[:chap_single_password].nil?
    import_host_system["chap_single_username"] = resource[:chap_single_username] unless resource[:chap_single_username].nil?
    import_host_system["id"] = resource[:id] unless resource[:id].nil?
    import_host_system["last_update_time"] = resource[:last_update_time] unless resource[:last_update_time].nil?
    import_host_system["os_type"] = resource[:os_type] unless resource[:os_type].nil?
    import_host_system["os_type_l10n"] = resource[:os_type_l10n] unless resource[:os_type_l10n].nil?
    import_host_system["os_version"] = resource[:os_version] unless resource[:os_version].nil?
    import_host_system["password"] = resource[:password] unless resource[:password].nil?
    import_host_system["user_name"] = resource[:user_name] unless resource[:user_name].nil?
    return import_host_system
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
    Puppet.info("Calling operation import_host_system_collection_query")
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/import_host_system', 'Get','application/json')
  end


  def self.invoke_create(context, resource = nil, body_params = nil)
    key_values = self.build_key_values
    Puppet.info("Calling operation import_host_system_create")
    path_params = {}
    query_params = {}
    header_params = {}
    header_params["User-Agent"] = ""
    
    op_params = [
      self.op_param('agent_address', 'body', 'agent_address', 'agent_address'),
      self.op_param('agent_port', 'body', 'agent_port', 'agent_port'),
      self.op_param('chap_mutual_password', 'body', 'chap_mutual_password', 'chap_mutual_password'),
      self.op_param('chap_mutual_username', 'body', 'chap_mutual_username', 'chap_mutual_username'),
      self.op_param('chap_single_password', 'body', 'chap_single_password', 'chap_single_password'),
      self.op_param('chap_single_username', 'body', 'chap_single_username', 'chap_single_username'),
      self.op_param('os_type', 'body', 'os_type', 'os_type'),
      self.op_param('password', 'body', 'password', 'password'),
      self.op_param('user_name', 'body', 'user_name', 'user_name'),
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/import_host_system', 'Post','application/json')
  end




  def self.invoke_delete(context, resource = nil, body_params = nil)
    key_values = self.build_key_values
    Puppet.info("Calling operation import_host_system_delete")
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/import_host_system/%{id}', 'Delete','application/json')
  end




  def self.invoke_get_one(context, resource = nil, body_params = nil)
    key_values = self.build_key_values
    Puppet.info("Calling operation import_host_system_instance_query")
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/import_host_system/%{id}', 'Get','application/json')
  end


  def self.fetch_all_as_hash(context)
    items = self.fetch_all(context)
    if items
      items.collect do |item|
        hash = {


          agent_address: item['agent_address'],
          agent_api_version: item['agent_api_version'],
          agent_port: item['agent_port'],
          agent_status: item['agent_status'],
          agent_status_l10n: item['agent_status_l10n'],
          agent_type: item['agent_type'],
          agent_type_l10n: item['agent_type_l10n'],
          agent_version: item['agent_version'],
          chap_mutual_password: item['chap_mutual_password'],
          chap_mutual_username: item['chap_mutual_username'],
          chap_single_password: item['chap_single_password'],
          chap_single_username: item['chap_single_username'],
          id: item['id'],
          last_update_time: item['last_update_time'],
          os_type: item['os_type'],
          os_type_l10n: item['os_type_l10n'],
          os_version: item['os_version'],
          password: item['password'],
          user_name: item['user_name'],
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
