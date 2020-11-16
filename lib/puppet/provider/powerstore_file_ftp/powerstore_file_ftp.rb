require 'puppet/resource_api'

# rubocop:disable Layout/EmptyLinesAroundClassBody

# class Puppet::Provider::PowerstoreFileFtp::PowerstoreFileFtp
class Puppet::Provider::PowerstoreFileFtp::PowerstoreFileFtp
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
    file_ftp = {}
    file_ftp['audit_dir'] = resource[:audit_dir] unless resource[:audit_dir].nil?
    file_ftp['audit_max_size'] = resource[:audit_max_size] unless resource[:audit_max_size].nil?
    file_ftp['default_homedir'] = resource[:default_homedir] unless resource[:default_homedir].nil?
    file_ftp['groups'] = resource[:groups] unless resource[:groups].nil?
    file_ftp['hosts'] = resource[:hosts] unless resource[:hosts].nil?
    file_ftp['is_allowed_groups'] = resource[:is_allowed_groups] unless resource[:is_allowed_groups].nil?
    file_ftp['is_allowed_hosts'] = resource[:is_allowed_hosts] unless resource[:is_allowed_hosts].nil?
    file_ftp['is_allowed_users'] = resource[:is_allowed_users] unless resource[:is_allowed_users].nil?
    file_ftp['is_anonymous_authentication_enabled'] = resource[:is_anonymous_authentication_enabled] unless resource[:is_anonymous_authentication_enabled].nil?
    file_ftp['is_audit_enabled'] = resource[:is_audit_enabled] unless resource[:is_audit_enabled].nil?
    file_ftp['is_ftp_enabled'] = resource[:is_ftp_enabled] unless resource[:is_ftp_enabled].nil?
    file_ftp['is_homedir_limit_enabled'] = resource[:is_homedir_limit_enabled] unless resource[:is_homedir_limit_enabled].nil?
    file_ftp['is_sftp_enabled'] = resource[:is_sftp_enabled] unless resource[:is_sftp_enabled].nil?
    file_ftp['is_smb_authentication_enabled'] = resource[:is_smb_authentication_enabled] unless resource[:is_smb_authentication_enabled].nil?
    file_ftp['is_unix_authentication_enabled'] = resource[:is_unix_authentication_enabled] unless resource[:is_unix_authentication_enabled].nil?
    file_ftp['message_of_the_day'] = resource[:message_of_the_day] unless resource[:message_of_the_day].nil?
    file_ftp['nas_server_id'] = resource[:nas_server_id] unless resource[:nas_server_id].nil?
    file_ftp['users'] = resource[:users] unless resource[:users].nil?
    file_ftp['welcome_message'] = resource[:welcome_message] unless resource[:welcome_message].nil?
    file_ftp
  end
  def build_update_hash(resource)
    file_ftp = {}
    file_ftp['add_groups'] = resource[:add_groups] unless resource[:add_groups].nil?
    file_ftp['add_hosts'] = resource[:add_hosts] unless resource[:add_hosts].nil?
    file_ftp['add_users'] = resource[:add_users] unless resource[:add_users].nil?
    file_ftp['audit_dir'] = resource[:audit_dir] unless resource[:audit_dir].nil?
    file_ftp['audit_max_size'] = resource[:audit_max_size] unless resource[:audit_max_size].nil?
    file_ftp['default_homedir'] = resource[:default_homedir] unless resource[:default_homedir].nil?
    file_ftp['groups'] = resource[:groups] unless resource[:groups].nil?
    file_ftp['hosts'] = resource[:hosts] unless resource[:hosts].nil?
    file_ftp['is_allowed_groups'] = resource[:is_allowed_groups] unless resource[:is_allowed_groups].nil?
    file_ftp['is_allowed_hosts'] = resource[:is_allowed_hosts] unless resource[:is_allowed_hosts].nil?
    file_ftp['is_allowed_users'] = resource[:is_allowed_users] unless resource[:is_allowed_users].nil?
    file_ftp['is_anonymous_authentication_enabled'] = resource[:is_anonymous_authentication_enabled] unless resource[:is_anonymous_authentication_enabled].nil?
    file_ftp['is_audit_enabled'] = resource[:is_audit_enabled] unless resource[:is_audit_enabled].nil?
    file_ftp['is_ftp_enabled'] = resource[:is_ftp_enabled] unless resource[:is_ftp_enabled].nil?
    file_ftp['is_homedir_limit_enabled'] = resource[:is_homedir_limit_enabled] unless resource[:is_homedir_limit_enabled].nil?
    file_ftp['is_sftp_enabled'] = resource[:is_sftp_enabled] unless resource[:is_sftp_enabled].nil?
    file_ftp['is_smb_authentication_enabled'] = resource[:is_smb_authentication_enabled] unless resource[:is_smb_authentication_enabled].nil?
    file_ftp['is_unix_authentication_enabled'] = resource[:is_unix_authentication_enabled] unless resource[:is_unix_authentication_enabled].nil?
    file_ftp['message_of_the_day'] = resource[:message_of_the_day] unless resource[:message_of_the_day].nil?
    file_ftp['remove_groups'] = resource[:remove_groups] unless resource[:remove_groups].nil?
    file_ftp['remove_hosts'] = resource[:remove_hosts] unless resource[:remove_hosts].nil?
    file_ftp['remove_users'] = resource[:remove_users] unless resource[:remove_users].nil?
    file_ftp['users'] = resource[:users] unless resource[:users].nil?
    file_ftp['welcome_message'] = resource[:welcome_message] unless resource[:welcome_message].nil?
    file_ftp
  end
  # rubocop:disable Lint/UnusedMethodArgument
  def build_delete_hash(resource)
    file_ftp = {}
    file_ftp
  end
  # rubocop:enable Lint/UnusedMethodArgument

  def build_hash(resource)
    file_ftp = {}
    file_ftp['add_groups'] = resource[:add_groups] unless resource[:add_groups].nil?
    file_ftp['add_hosts'] = resource[:add_hosts] unless resource[:add_hosts].nil?
    file_ftp['add_users'] = resource[:add_users] unless resource[:add_users].nil?
    file_ftp['audit_dir'] = resource[:audit_dir] unless resource[:audit_dir].nil?
    file_ftp['audit_max_size'] = resource[:audit_max_size] unless resource[:audit_max_size].nil?
    file_ftp['default_homedir'] = resource[:default_homedir] unless resource[:default_homedir].nil?
    file_ftp['groups'] = resource[:groups] unless resource[:groups].nil?
    file_ftp['hosts'] = resource[:hosts] unless resource[:hosts].nil?
    file_ftp['id'] = resource[:id] unless resource[:id].nil?
    file_ftp['is_allowed_groups'] = resource[:is_allowed_groups] unless resource[:is_allowed_groups].nil?
    file_ftp['is_allowed_hosts'] = resource[:is_allowed_hosts] unless resource[:is_allowed_hosts].nil?
    file_ftp['is_allowed_users'] = resource[:is_allowed_users] unless resource[:is_allowed_users].nil?
    file_ftp['is_anonymous_authentication_enabled'] = resource[:is_anonymous_authentication_enabled] unless resource[:is_anonymous_authentication_enabled].nil?
    file_ftp['is_audit_enabled'] = resource[:is_audit_enabled] unless resource[:is_audit_enabled].nil?
    file_ftp['is_ftp_enabled'] = resource[:is_ftp_enabled] unless resource[:is_ftp_enabled].nil?
    file_ftp['is_homedir_limit_enabled'] = resource[:is_homedir_limit_enabled] unless resource[:is_homedir_limit_enabled].nil?
    file_ftp['is_sftp_enabled'] = resource[:is_sftp_enabled] unless resource[:is_sftp_enabled].nil?
    file_ftp['is_smb_authentication_enabled'] = resource[:is_smb_authentication_enabled] unless resource[:is_smb_authentication_enabled].nil?
    file_ftp['is_unix_authentication_enabled'] = resource[:is_unix_authentication_enabled] unless resource[:is_unix_authentication_enabled].nil?
    file_ftp['message_of_the_day'] = resource[:message_of_the_day] unless resource[:message_of_the_day].nil?
    file_ftp['nas_server_id'] = resource[:nas_server_id] unless resource[:nas_server_id].nil?
    file_ftp['remove_groups'] = resource[:remove_groups] unless resource[:remove_groups].nil?
    file_ftp['remove_hosts'] = resource[:remove_hosts] unless resource[:remove_hosts].nil?
    file_ftp['remove_users'] = resource[:remove_users] unless resource[:remove_users].nil?
    file_ftp['users'] = resource[:users] unless resource[:users].nil?
    file_ftp['welcome_message'] = resource[:welcome_message] unless resource[:welcome_message].nil?
    file_ftp
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
    Puppet.info('Calling operation file_ftp_collection_query')
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/file_ftp', 'Get', 'application/json')
  end


  def self.invoke_create(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation file_ftp_create')
    path_params = {}
    query_params = {}
    header_params = {}
    header_params['User-Agent'] = ''

    op_params = [
      op_param('audit_dir', 'body', 'audit_dir', 'audit_dir'),
      op_param('audit_max_size', 'body', 'audit_max_size', 'audit_max_size'),
      op_param('default_homedir', 'body', 'default_homedir', 'default_homedir'),
      op_param('groups', 'body', 'groups', 'groups'),
      op_param('hosts', 'body', 'hosts', 'hosts'),
      op_param('is_allowed_groups', 'body', 'is_allowed_groups', 'is_allowed_groups'),
      op_param('is_allowed_hosts', 'body', 'is_allowed_hosts', 'is_allowed_hosts'),
      op_param('is_allowed_users', 'body', 'is_allowed_users', 'is_allowed_users'),
      op_param('is_anonymous_authentication_enabled', 'body', 'is_anonymous_authentication_enabled', 'is_anonymous_authentication_enabled'),
      op_param('is_audit_enabled', 'body', 'is_audit_enabled', 'is_audit_enabled'),
      op_param('is_ftp_enabled', 'body', 'is_ftp_enabled', 'is_ftp_enabled'),
      op_param('is_homedir_limit_enabled', 'body', 'is_homedir_limit_enabled', 'is_homedir_limit_enabled'),
      op_param('is_sftp_enabled', 'body', 'is_sftp_enabled', 'is_sftp_enabled'),
      op_param('is_smb_authentication_enabled', 'body', 'is_smb_authentication_enabled', 'is_smb_authentication_enabled'),
      op_param('is_unix_authentication_enabled', 'body', 'is_unix_authentication_enabled', 'is_unix_authentication_enabled'),
      op_param('message_of_the_day', 'body', 'message_of_the_day', 'message_of_the_day'),
      op_param('nas_server_id', 'body', 'nas_server_id', 'nas_server_id'),
      op_param('users', 'body', 'users', 'users'),
      op_param('welcome_message', 'body', 'welcome_message', 'welcome_message'),
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/file_ftp', 'Post', 'application/json')
  end


  def self.invoke_update(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation file_ftp_modify')
    path_params = {}
    query_params = {}
    header_params = {}
    header_params['User-Agent'] = ''

    op_params = [
      op_param('add_groups', 'body', 'add_groups', 'add_groups'),
      op_param('add_hosts', 'body', 'add_hosts', 'add_hosts'),
      op_param('add_users', 'body', 'add_users', 'add_users'),
      op_param('audit_dir', 'body', 'audit_dir', 'audit_dir'),
      op_param('audit_max_size', 'body', 'audit_max_size', 'audit_max_size'),
      op_param('default_homedir', 'body', 'default_homedir', 'default_homedir'),
      op_param('groups', 'body', 'groups', 'groups'),
      op_param('hosts', 'body', 'hosts', 'hosts'),
      op_param('id', 'path', 'id', 'id'),
      op_param('is_allowed_groups', 'body', 'is_allowed_groups', 'is_allowed_groups'),
      op_param('is_allowed_hosts', 'body', 'is_allowed_hosts', 'is_allowed_hosts'),
      op_param('is_allowed_users', 'body', 'is_allowed_users', 'is_allowed_users'),
      op_param('is_anonymous_authentication_enabled', 'body', 'is_anonymous_authentication_enabled', 'is_anonymous_authentication_enabled'),
      op_param('is_audit_enabled', 'body', 'is_audit_enabled', 'is_audit_enabled'),
      op_param('is_ftp_enabled', 'body', 'is_ftp_enabled', 'is_ftp_enabled'),
      op_param('is_homedir_limit_enabled', 'body', 'is_homedir_limit_enabled', 'is_homedir_limit_enabled'),
      op_param('is_sftp_enabled', 'body', 'is_sftp_enabled', 'is_sftp_enabled'),
      op_param('is_smb_authentication_enabled', 'body', 'is_smb_authentication_enabled', 'is_smb_authentication_enabled'),
      op_param('is_unix_authentication_enabled', 'body', 'is_unix_authentication_enabled', 'is_unix_authentication_enabled'),
      op_param('message_of_the_day', 'body', 'message_of_the_day', 'message_of_the_day'),
      op_param('remove_groups', 'body', 'remove_groups', 'remove_groups'),
      op_param('remove_hosts', 'body', 'remove_hosts', 'remove_hosts'),
      op_param('remove_users', 'body', 'remove_users', 'remove_users'),
      op_param('users', 'body', 'users', 'users'),
      op_param('welcome_message', 'body', 'welcome_message', 'welcome_message'),
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/file_ftp/%{id}', 'Patch', 'application/json')
  end


  def self.invoke_delete(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation file_ftp_delete')
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/file_ftp/%{id}', 'Delete', 'application/json')
  end




  def self.invoke_get_one(context, resource = nil, body_params = nil)
    key_values = build_key_values
    Puppet.info('Calling operation file_ftp_instance_query')
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/file_ftp/%{id}', 'Get', 'application/json')
  end


  def self.fetch_all_as_hash(context)
    items = fetch_all(context)
    if items
      items.map { |item|
        hash = {
          add_groups: item['add_groups'],
          add_hosts: item['add_hosts'],
          add_users: item['add_users'],
          audit_dir: item['audit_dir'],
          audit_max_size: item['audit_max_size'],
          default_homedir: item['default_homedir'],
          groups: item['groups'],
          hosts: item['hosts'],
          id: item['id'],
          is_allowed_groups: item['is_allowed_groups'],
          is_allowed_hosts: item['is_allowed_hosts'],
          is_allowed_users: item['is_allowed_users'],
          is_anonymous_authentication_enabled: item['is_anonymous_authentication_enabled'],
          is_audit_enabled: item['is_audit_enabled'],
          is_ftp_enabled: item['is_ftp_enabled'],
          is_homedir_limit_enabled: item['is_homedir_limit_enabled'],
          is_sftp_enabled: item['is_sftp_enabled'],
          is_smb_authentication_enabled: item['is_smb_authentication_enabled'],
          is_unix_authentication_enabled: item['is_unix_authentication_enabled'],
          message_of_the_day: item['message_of_the_day'],
          nas_server_id: item['nas_server_id'],
          remove_groups: item['remove_groups'],
          remove_hosts: item['remove_hosts'],
          remove_users: item['remove_users'],
          users: item['users'],
          welcome_message: item['welcome_message'],
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
