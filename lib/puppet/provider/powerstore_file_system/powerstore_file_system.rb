require 'puppet/resource_api'
require "pry"

class Puppet::Provider::PowerstoreFileSystem::PowerstoreFileSystem
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
    file_system = {}
    file_system["access_policy"] = resource[:access_policy] unless resource[:access_policy].nil?
    file_system["description"] = resource[:description] unless resource[:description].nil?
    file_system["folder_rename_policy"] = resource[:folder_rename_policy] unless resource[:folder_rename_policy].nil?
    file_system["is_async_MTime_enabled"] = resource[:is_async_m_time_enabled] unless resource[:is_async_m_time_enabled].nil?
    file_system["is_smb_no_notify_enabled"] = resource[:is_smb_no_notify_enabled] unless resource[:is_smb_no_notify_enabled].nil?
    file_system["is_smb_notify_on_access_enabled"] = resource[:is_smb_notify_on_access_enabled] unless resource[:is_smb_notify_on_access_enabled].nil?
    file_system["is_smb_notify_on_write_enabled"] = resource[:is_smb_notify_on_write_enabled] unless resource[:is_smb_notify_on_write_enabled].nil?
    file_system["is_smb_op_locks_enabled"] = resource[:is_smb_op_locks_enabled] unless resource[:is_smb_op_locks_enabled].nil?
    file_system["is_smb_sync_writes_enabled"] = resource[:is_smb_sync_writes_enabled] unless resource[:is_smb_sync_writes_enabled].nil?
    file_system["locking_policy"] = resource[:locking_policy] unless resource[:locking_policy].nil?
    file_system["name"] = resource[:name] unless resource[:name].nil?
    file_system["nas_server_id"] = resource[:nas_server_id] unless resource[:nas_server_id].nil?
    file_system["protection_policy_id"] = resource[:protection_policy_id] unless resource[:protection_policy_id].nil?
    file_system["size_total"] = resource[:size_total] unless resource[:size_total].nil?
    file_system["smb_notify_on_change_dir_depth"] = resource[:smb_notify_on_change_dir_depth] unless resource[:smb_notify_on_change_dir_depth].nil?
    return file_system
  end

  def build_update_hash(resource)
    file_system = {}
    file_system["access_policy"] = resource[:access_policy] unless resource[:access_policy].nil?
    file_system["default_hard_limit"] = resource[:default_hard_limit] unless resource[:default_hard_limit].nil?
    file_system["default_soft_limit"] = resource[:default_soft_limit] unless resource[:default_soft_limit].nil?
    file_system["description"] = resource[:description] unless resource[:description].nil?
    file_system["expiration_timestamp"] = resource[:expiration_timestamp] unless resource[:expiration_timestamp].nil?
    file_system["folder_rename_policy"] = resource[:folder_rename_policy] unless resource[:folder_rename_policy].nil?
    file_system["grace_period"] = resource[:grace_period] unless resource[:grace_period].nil?
    file_system["is_async_MTime_enabled"] = resource[:is_async_m_time_enabled] unless resource[:is_async_m_time_enabled].nil?
    file_system["is_quota_enabled"] = resource[:is_quota_enabled] unless resource[:is_quota_enabled].nil?
    file_system["is_smb_no_notify_enabled"] = resource[:is_smb_no_notify_enabled] unless resource[:is_smb_no_notify_enabled].nil?
    file_system["is_smb_notify_on_access_enabled"] = resource[:is_smb_notify_on_access_enabled] unless resource[:is_smb_notify_on_access_enabled].nil?
    file_system["is_smb_notify_on_write_enabled"] = resource[:is_smb_notify_on_write_enabled] unless resource[:is_smb_notify_on_write_enabled].nil?
    file_system["is_smb_op_locks_enabled"] = resource[:is_smb_op_locks_enabled] unless resource[:is_smb_op_locks_enabled].nil?
    file_system["is_smb_sync_writes_enabled"] = resource[:is_smb_sync_writes_enabled] unless resource[:is_smb_sync_writes_enabled].nil?
    file_system["locking_policy"] = resource[:locking_policy] unless resource[:locking_policy].nil?
    file_system["protection_policy_id"] = resource[:protection_policy_id] unless resource[:protection_policy_id].nil?
    file_system["size_total"] = resource[:size_total] unless resource[:size_total].nil?
    file_system["smb_notify_on_change_dir_depth"] = resource[:smb_notify_on_change_dir_depth] unless resource[:smb_notify_on_change_dir_depth].nil?
    return file_system
  end

  def build_delete_hash(resource)
    file_system = {}
    return file_system
  end

  def build_hash(resource)
    file_system = {}
    file_system["access_policy"] = resource[:access_policy] unless resource[:access_policy].nil?
    file_system["access_policy_l10n"] = resource[:access_policy_l10n] unless resource[:access_policy_l10n].nil?
    file_system["access_type"] = resource[:access_type] unless resource[:access_type].nil?
    file_system["access_type_l10n"] = resource[:access_type_l10n] unless resource[:access_type_l10n].nil?
    file_system["creation_timestamp"] = resource[:creation_timestamp] unless resource[:creation_timestamp].nil?
    file_system["creator_type"] = resource[:creator_type] unless resource[:creator_type].nil?
    file_system["creator_type_l10n"] = resource[:creator_type_l10n] unless resource[:creator_type_l10n].nil?
    file_system["default_hard_limit"] = resource[:default_hard_limit] unless resource[:default_hard_limit].nil?
    file_system["default_soft_limit"] = resource[:default_soft_limit] unless resource[:default_soft_limit].nil?
    file_system["description"] = resource[:description] unless resource[:description].nil?
    file_system["expiration_timestamp"] = resource[:expiration_timestamp] unless resource[:expiration_timestamp].nil?
    file_system["filesystem_type"] = resource[:filesystem_type] unless resource[:filesystem_type].nil?
    file_system["filesystem_type_l10n"] = resource[:filesystem_type_l10n] unless resource[:filesystem_type_l10n].nil?
    file_system["folder_rename_policy"] = resource[:folder_rename_policy] unless resource[:folder_rename_policy].nil?
    file_system["folder_rename_policy_l10n"] = resource[:folder_rename_policy_l10n] unless resource[:folder_rename_policy_l10n].nil?
    file_system["grace_period"] = resource[:grace_period] unless resource[:grace_period].nil?
    file_system["id"] = resource[:id] unless resource[:id].nil?
    file_system["is_async_MTime_enabled"] = resource[:is_async_m_time_enabled] unless resource[:is_async_m_time_enabled].nil?
    file_system["is_modified"] = resource[:is_modified] unless resource[:is_modified].nil?
    file_system["is_quota_enabled"] = resource[:is_quota_enabled] unless resource[:is_quota_enabled].nil?
    file_system["is_smb_no_notify_enabled"] = resource[:is_smb_no_notify_enabled] unless resource[:is_smb_no_notify_enabled].nil?
    file_system["is_smb_notify_on_access_enabled"] = resource[:is_smb_notify_on_access_enabled] unless resource[:is_smb_notify_on_access_enabled].nil?
    file_system["is_smb_notify_on_write_enabled"] = resource[:is_smb_notify_on_write_enabled] unless resource[:is_smb_notify_on_write_enabled].nil?
    file_system["is_smb_op_locks_enabled"] = resource[:is_smb_op_locks_enabled] unless resource[:is_smb_op_locks_enabled].nil?
    file_system["is_smb_sync_writes_enabled"] = resource[:is_smb_sync_writes_enabled] unless resource[:is_smb_sync_writes_enabled].nil?
    file_system["last_refresh_timestamp"] = resource[:last_refresh_timestamp] unless resource[:last_refresh_timestamp].nil?
    file_system["last_writable_timestamp"] = resource[:last_writable_timestamp] unless resource[:last_writable_timestamp].nil?
    file_system["locking_policy"] = resource[:locking_policy] unless resource[:locking_policy].nil?
    file_system["locking_policy_l10n"] = resource[:locking_policy_l10n] unless resource[:locking_policy_l10n].nil?
    file_system["name"] = resource[:name] unless resource[:name].nil?
    file_system["nas_server_id"] = resource[:nas_server_id] unless resource[:nas_server_id].nil?
    file_system["parent_id"] = resource[:parent_id] unless resource[:parent_id].nil?
    file_system["protection_policy_id"] = resource[:protection_policy_id] unless resource[:protection_policy_id].nil?
    file_system["size_total"] = resource[:size_total] unless resource[:size_total].nil?
    file_system["size_used"] = resource[:size_used] unless resource[:size_used].nil?
    file_system["smb_notify_on_change_dir_depth"] = resource[:smb_notify_on_change_dir_depth] unless resource[:smb_notify_on_change_dir_depth].nil?
    return file_system
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
    Puppet.info("Calling operation file_system_collection_query")
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/file_system', 'Get','application/json')
  end


  def self.invoke_create(context, resource = nil, body_params = nil)
    key_values = self.build_key_values
    Puppet.info("Calling operation file_system_create")
    path_params = {}
    query_params = {}
    header_params = {}
    header_params["User-Agent"] = ""
    
    op_params = [
      self.op_param('access_policy', 'body', 'access_policy', 'access_policy'),
      self.op_param('description', 'body', 'description', 'description'),
      self.op_param('folder_rename_policy', 'body', 'folder_rename_policy', 'folder_rename_policy'),
      self.op_param('is_async_MTime_enabled', 'body', 'is_async_m_time_enabled', 'is_async_m_time_enabled'),
      self.op_param('is_smb_no_notify_enabled', 'body', 'is_smb_no_notify_enabled', 'is_smb_no_notify_enabled'),
      self.op_param('is_smb_notify_on_access_enabled', 'body', 'is_smb_notify_on_access_enabled', 'is_smb_notify_on_access_enabled'),
      self.op_param('is_smb_notify_on_write_enabled', 'body', 'is_smb_notify_on_write_enabled', 'is_smb_notify_on_write_enabled'),
      self.op_param('is_smb_op_locks_enabled', 'body', 'is_smb_op_locks_enabled', 'is_smb_op_locks_enabled'),
      self.op_param('is_smb_sync_writes_enabled', 'body', 'is_smb_sync_writes_enabled', 'is_smb_sync_writes_enabled'),
      self.op_param('locking_policy', 'body', 'locking_policy', 'locking_policy'),
      self.op_param('name', 'body', 'name', 'name'),
      self.op_param('nas_server_id', 'body', 'nas_server_id', 'nas_server_id'),
      self.op_param('protection_policy_id', 'body', 'protection_policy_id', 'protection_policy_id'),
      self.op_param('size_total', 'body', 'size_total', 'size_total'),
      self.op_param('smb_notify_on_change_dir_depth', 'body', 'smb_notify_on_change_dir_depth', 'smb_notify_on_change_dir_depth'),
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/file_system', 'Post','application/json')
  end


  def self.invoke_update(context, resource = nil, body_params = nil)
    key_values = self.build_key_values
    Puppet.info("Calling operation file_system_modify")
    path_params = {}
    query_params = {}
    header_params = {}
    header_params["User-Agent"] = ""
    
    op_params = [
      self.op_param('access_policy', 'body', 'access_policy', 'access_policy'),
      self.op_param('default_hard_limit', 'body', 'default_hard_limit', 'default_hard_limit'),
      self.op_param('default_soft_limit', 'body', 'default_soft_limit', 'default_soft_limit'),
      self.op_param('description', 'body', 'description', 'description'),
      self.op_param('expiration_timestamp', 'body', 'expiration_timestamp', 'expiration_timestamp'),
      self.op_param('folder_rename_policy', 'body', 'folder_rename_policy', 'folder_rename_policy'),
      self.op_param('grace_period', 'body', 'grace_period', 'grace_period'),
      self.op_param('id', 'path', 'id', 'id'),
      self.op_param('is_async_MTime_enabled', 'body', 'is_async_m_time_enabled', 'is_async_m_time_enabled'),
      self.op_param('is_quota_enabled', 'body', 'is_quota_enabled', 'is_quota_enabled'),
      self.op_param('is_smb_no_notify_enabled', 'body', 'is_smb_no_notify_enabled', 'is_smb_no_notify_enabled'),
      self.op_param('is_smb_notify_on_access_enabled', 'body', 'is_smb_notify_on_access_enabled', 'is_smb_notify_on_access_enabled'),
      self.op_param('is_smb_notify_on_write_enabled', 'body', 'is_smb_notify_on_write_enabled', 'is_smb_notify_on_write_enabled'),
      self.op_param('is_smb_op_locks_enabled', 'body', 'is_smb_op_locks_enabled', 'is_smb_op_locks_enabled'),
      self.op_param('is_smb_sync_writes_enabled', 'body', 'is_smb_sync_writes_enabled', 'is_smb_sync_writes_enabled'),
      self.op_param('locking_policy', 'body', 'locking_policy', 'locking_policy'),
      self.op_param('protection_policy_id', 'body', 'protection_policy_id', 'protection_policy_id'),
      self.op_param('size_total', 'body', 'size_total', 'size_total'),
      self.op_param('smb_notify_on_change_dir_depth', 'body', 'smb_notify_on_change_dir_depth', 'smb_notify_on_change_dir_depth'),
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/file_system/%{id}', 'Patch','application/json')
  end


  def self.invoke_delete(context, resource = nil, body_params = nil)
    key_values = self.build_key_values
    Puppet.info("Calling operation file_system_delete")
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/file_system/%{id}', 'Delete','application/json')
  end




  def self.invoke_get_one(context, resource = nil, body_params = nil)
    key_values = self.build_key_values
    Puppet.info("Calling operation file_system_instance_query")
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/file_system/%{id}', 'Get','application/json')
  end


  def self.fetch_all_as_hash(context)
    items = self.fetch_all(context)
    if items
      items.collect do |item|
        hash = {


          access_policy: item['access_policy'],
          access_policy_l10n: item['access_policy_l10n'],
          access_type: item['access_type'],
          access_type_l10n: item['access_type_l10n'],
          creation_timestamp: item['creation_timestamp'],
          creator_type: item['creator_type'],
          creator_type_l10n: item['creator_type_l10n'],
          default_hard_limit: item['default_hard_limit'],
          default_soft_limit: item['default_soft_limit'],
          description: item['description'],
          expiration_timestamp: item['expiration_timestamp'],
          filesystem_type: item['filesystem_type'],
          filesystem_type_l10n: item['filesystem_type_l10n'],
          folder_rename_policy: item['folder_rename_policy'],
          folder_rename_policy_l10n: item['folder_rename_policy_l10n'],
          grace_period: item['grace_period'],
          id: item['id'],
          is_async_m_time_enabled: item['is_async_MTime_enabled'],
          is_modified: item['is_modified'],
          is_quota_enabled: item['is_quota_enabled'],
          is_smb_no_notify_enabled: item['is_smb_no_notify_enabled'],
          is_smb_notify_on_access_enabled: item['is_smb_notify_on_access_enabled'],
          is_smb_notify_on_write_enabled: item['is_smb_notify_on_write_enabled'],
          is_smb_op_locks_enabled: item['is_smb_op_locks_enabled'],
          is_smb_sync_writes_enabled: item['is_smb_sync_writes_enabled'],
          last_refresh_timestamp: item['last_refresh_timestamp'],
          last_writable_timestamp: item['last_writable_timestamp'],
          locking_policy: item['locking_policy'],
          locking_policy_l10n: item['locking_policy_l10n'],
          name: item['name'],
          nas_server_id: item['nas_server_id'],
          parent_id: item['parent_id'],
          protection_policy_id: item['protection_policy_id'],
          size_total: item['size_total'],
          size_used: item['size_used'],
          smb_notify_on_change_dir_depth: item['smb_notify_on_change_dir_depth'],
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
