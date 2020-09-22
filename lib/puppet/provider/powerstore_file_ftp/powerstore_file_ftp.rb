require 'puppet/resource_api'
require "pry"

class Puppet::Provider::PowerstoreFile_ftp::PowerstoreFile_ftp
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
    #binding.pry
    context.debug("Entered set")


    changes.each do |name, change|
      #binding.pry
      context.debug("set change with #{name} and #{change}")
      is = change.key?(:is) ? change[:is] : get(context).find { |key| key[:id] == name }
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
      #binding.pry
      new_hash = build_hash(should)
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
      new_hash = build_hash(should)
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

  def build_hash(resource)
    file_ftp = {}
    file_ftp["add_groups"] = resource[:add_groups] unless resource[:add_groups].nil?
    file_ftp["add_hosts"] = resource[:add_hosts] unless resource[:add_hosts].nil?
    file_ftp["add_users"] = resource[:add_users] unless resource[:add_users].nil?
    file_ftp["audit_dir"] = resource[:audit_dir] unless resource[:audit_dir].nil?
    file_ftp["audit_max_size"] = resource[:audit_max_size] unless resource[:audit_max_size].nil?
    file_ftp["default_homedir"] = resource[:default_homedir] unless resource[:default_homedir].nil?
    file_ftp["groups"] = resource[:groups] unless resource[:groups].nil?
    file_ftp["hosts"] = resource[:hosts] unless resource[:hosts].nil?
    file_ftp["id"] = resource[:id] unless resource[:id].nil?
    file_ftp["is_allowed_groups"] = resource[:is_allowed_groups] unless resource[:is_allowed_groups].nil?
    file_ftp["is_allowed_hosts"] = resource[:is_allowed_hosts] unless resource[:is_allowed_hosts].nil?
    file_ftp["is_allowed_users"] = resource[:is_allowed_users] unless resource[:is_allowed_users].nil?
    file_ftp["is_anonymous_authentication_enabled"] = resource[:is_anonymous_authentication_enabled] unless resource[:is_anonymous_authentication_enabled].nil?
    file_ftp["is_audit_enabled"] = resource[:is_audit_enabled] unless resource[:is_audit_enabled].nil?
    file_ftp["is_ftp_enabled"] = resource[:is_ftp_enabled] unless resource[:is_ftp_enabled].nil?
    file_ftp["is_homedir_limit_enabled"] = resource[:is_homedir_limit_enabled] unless resource[:is_homedir_limit_enabled].nil?
    file_ftp["is_sftp_enabled"] = resource[:is_sftp_enabled] unless resource[:is_sftp_enabled].nil?
    file_ftp["is_smb_authentication_enabled"] = resource[:is_smb_authentication_enabled] unless resource[:is_smb_authentication_enabled].nil?
    file_ftp["is_unix_authentication_enabled"] = resource[:is_unix_authentication_enabled] unless resource[:is_unix_authentication_enabled].nil?
    file_ftp["message_of_the_day"] = resource[:message_of_the_day] unless resource[:message_of_the_day].nil?
    file_ftp["nas_server_id"] = resource[:nas_server_id] unless resource[:nas_server_id].nil?
    file_ftp["remove_groups"] = resource[:remove_groups] unless resource[:remove_groups].nil?
    file_ftp["remove_hosts"] = resource[:remove_hosts] unless resource[:remove_hosts].nil?
    file_ftp["remove_users"] = resource[:remove_users] unless resource[:remove_users].nil?
    file_ftp["users"] = resource[:users] unless resource[:users].nil?
    file_ftp["welcome_message"] = resource[:welcome_message] unless resource[:welcome_message].nil?
    return file_ftp
  end

  def self.build_key_values
    key_values = {}
    
    key_values["api-version"] = "specs"
    key_values
  end

  # def destroy(context)
  #   delete(context, resource)
  # end

  def delete(context, should)
    new_hash = build_hash(should)
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
    Puppet.info("Calling operation file_ftpCollectionQuery")
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/file_ftp', 'Get','application/json')
  end


  def self.invoke_create(context, resource = nil, body_params = nil)
    key_values = self.build_key_values
    Puppet.info("Calling operation file_ftpCreate")
    path_params = {}
    query_params = {}
    header_params = {}
    header_params["User-Agent"] = ""
    
    op_params = [
      self.op_param('body', 'body', 'body', 'body'),
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/file_ftp', 'Post','application/json')
  end


  def self.invoke_update(context, resource = nil, body_params = nil)
    key_values = self.build_key_values
    Puppet.info("Calling operation file_ftpModify")
    path_params = {}
    query_params = {}
    header_params = {}
    header_params["User-Agent"] = ""
    
    op_params = [
      self.op_param('body', 'body', 'body', 'body'),
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/file_ftp/%{id}', 'Patch','application/json')
  end


  def self.invoke_delete(context, resource = nil, body_params = nil)
    key_values = self.build_key_values
    Puppet.info("Calling operation file_ftpDelete")
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/file_ftp/%{id}', 'Delete','application/json')
  end




  def self.invoke_get_one(context, resource = nil, body_params = nil)
    key_values = self.build_key_values
    Puppet.info("Calling operation file_ftpInstanceQuery")
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
    context.transport.call_op(path_params, query_params, header_params, body_params, '/file_ftp/%{id}', 'Get','application/json')
  end


  def self.fetch_all_as_hash(context)
    items = self.fetch_all(context)
    if items
      items.collect do |item|
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

  # def self.call_op(path_params, query_params, header_params, body_params, operation_path, operation_verb, parent_consumes)
  #   uri_string = "https://#{ENV["gen_endpoint"]}#{operation_path}" % path_params
  #   uri_string = uri_string + "?" + to_query(query_params)
  #   header_params['Content-Type'] = 'application/json' # first of #{parent_consumes}
  #   if authenticate(path_params, query_params, header_params, body_params)
  #     Puppet.info("Authentication succeeded")
  #     uri = URI(uri_string)
  #     Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
  #       if operation_verb == 'Get'
  #         req = Net::HTTP::Get.new(uri)
  #       elsif operation_verb == 'Put'
  #         req = Net::HTTP::Put.new(uri)
  #       elsif operation_verb == 'Delete'
  #         req = Net::HTTP::Delete.new(uri)
	# 	elsif operation_verb == 'Post'
  #         req = Net::HTTP::Post.new(uri)
  #       end
  #       add_keys_to_request(req, header_params)
  #       if body_params
  #         req.body = body_params.to_json
  #       end
  #       Puppet.debug("URI is (#{operation_verb}) #{uri}, body is #{body_params}, query params are #{query_params}, headers are #{header_params}")
  #       response = http.request req # Net::HTTPResponse object
  #       Puppet.debug("response code is #{response.code} and body is #{response.body}")
  #       success = response.is_a? Net::HTTPSuccess
  #       Puppet.info("Called (#{operation_verb}) endpoint at #{uri}, success was #{success}")
  #       return response
  #     end
  #   end
  # end

end
