require 'uri'
require 'json'
require 'rest-client'

module Puppet::Transport

  # The main connection class to a Device endpoint
  class Powerstore
    def connection_info
      @connection_info
    end

    def initialize(_context, connection_info)
      connection_info[:schema] ||= 'https'
      connection_info[:port] ||= 443
      connection_info[:base_path] ||= '/api/rest'
      @connection_info = connection_info
      @auth_headers = {}

      # TODO: Add additional validation for connection_info
      # port = connection_info[:port].nil? ? 443 : connection_info[:port]
      # Puppet.debug "Trying to connect to #{connection_info[:host]}:#{port} as user #{connection_info[:user]}"
      # NOTE: the authentication header only needs to be sent in the first request
      # subsequent requests are authenticated using the persistent cookie returned from the first request
      # see https://www.dellemc.com/en-us/collaterals/unauth/technical-guides-support-information/products/storage/docu69331.pdf
      # page 44: Connecting and authenticating
      RestClient.log = STDOUT if Puppet.debug

      # headers =  {
      #   'X-EMC-REST-CLIENT' => 'true',
      #   'Content-Type'      => 'application/json',
      #   'Accept'            => 'application/json'
      #   }

      # @api = RestClient::Resource.new("https://#{connection_info[:host]}:#{port}/api",
      #                                 user:       connection_info[:user],
      #                                 password:   connection_info[:password].unwrap,
      #                                 headers:    headers,
      #                                 verify_ssl: OpenSSL::SSL::VERIFY_NONE)
      # # do an initial authenticated request to get cookies and the CSRF token
      # response = @api['types/job/instances'].get
      # now configure the client for subsequent requests without credentials
      # but with cookies and the CSRF token (needed for POST and DELETE requests)
      # headers['EMC-CSRF-TOKEN'] = response.headers[:emc_csrf_token]
      # @api = RestClient::Resource.new("https://#{connection_info[:host]}:#{port}/api",
      #     headers: headers,
      #     # cookies: response.cookie_jar,
      #     verify_ssl: OpenSSL::SSL::VERIFY_NONE)
    end

    # Shared methods
    
    def to_query(hash)
      if hash
        return_value = hash.map { |x, v| "#{x}=#{v}" }.reduce { |x, v| "#{x}&#{v}" }
        if !return_value.nil?
          return return_value
        end
      end
      return ''
    end
  
    def authenticate(path_params, query_params, header_params, body_params)
      return true if connection_info[:auth] == 'none'
      
      uri_string = "#{connection_info[:schema]}://#{connection_info[:host]}:#{connection_info[:port]}#{connection_info[:base_path]}/appliance"
      uri = URI(uri_string)
      req = Net::HTTP::Get.new(uri)
      req.basic_auth @connection_info[:user], connection_info[:password].unwrap
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      http.start
      begin
        response = http.request req # Net::HTTPResponse object
        @auth_headers['DELL-EMC-TOKEN'] = response['DELL-EMC-TOKEN'] || 'auth_token'
        @auth_headers['Cookie'] = response['Set-Cookie'] || 'auth_cookie'
        true
      rescue StandardError => e
        STDOUT.print({ _error: e.to_h }.to_json)
        false
      end
    end

    def add_keys_to_request(request, hash)
      if hash
        hash.each { |x, v| request[x] = v }
      end
      if @auth_headers
        @auth_headers.each { |x, v| request[x] = v } 
      end
    end
  
    def call_op(path_params, query_params, header_params, body_params, operation_path, operation_verb, parent_consumes)
      uri_string = "#{connection_info[:schema]}://#{connection_info[:host]}:#{connection_info[:port]}#{connection_info[:base_path]}#{operation_path}" % path_params
      if query_params.size > 0
        uri_string = uri_string + '?' + to_query(query_params)
      end
      header_params['Content-Type'] = parent_consumes
      verify_mode= OpenSSL::SSL::VERIFY_NONE
      # if arg_hash['ca_file']
      #   verify_mode=OpenSSL::SSL::VERIFY_PEER
      # end

      if authenticate(path_params, query_params, header_params, body_params)
        Puppet.info("Authentication succeeded")
        uri = URI(uri_string)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == 'https'
        http.verify_mode = verify_mode
        if operation_verb == 'Get'
          req = Net::HTTP::Get.new(uri)
        elsif operation_verb == 'Put'
          req = Net::HTTP::Put.new(uri)
        elsif operation_verb == 'Patch'
          req = Net::HTTP::Patch.new(uri)
        elsif operation_verb == 'Delete'
          req = Net::HTTP::Delete.new(uri)
        elsif operation_verb == 'Post'
          req = Net::HTTP::Post.new(uri)
        end
        add_keys_to_request(req, header_params)
        unless ! body_params || body_params.empty?
          if body_params.key?('file_content')
            req.body = body_params['file_content']
          else
            req.body = body_params.to_json
          end
        end
        Puppet.debug("URI is (#{operation_verb}) #{uri}, body is #{body_params}, query params are #{query_params}, headers are #{header_params}")
        http.start {
          response = http.request req # Net::HTTPResponse object
          Puppet.debug("response code is #{response.code} and body is #{response.body}")
          success = response.is_a? Net::HTTPSuccess
          Puppet.info("Called (#{operation_verb}) endpoint at #{uri}, success was #{success}")
          return response
        }
      end
    end

    # # Return Unity resource fields for a given Puppet type
    # def fields_for_type(type)
    #   # hack: allow for omitting the "unity_" prefix
    #   # require 'pry';binding.pry
    #   type = type.downcase
    #   type = "unity_#{type}" unless type.start_with?('unity_')
    #   attributes = Puppet::Type.type(type.to_sym).context.type.attributes
    #   attributes.values.map { |v| v[:field_name] }.select { |f| !f.nil? }
    # end

    # @summary
    #   Returns device's facts
    def facts(_context)
      # require 'pry';binding.pry
      {
        "fact1"      => 'value1',
      }
    end

    def verify(context)
      # Test that transport can talk to the remote target
    end

    def close(_context)
      # Close connection, free up resources
    end
  end
end
