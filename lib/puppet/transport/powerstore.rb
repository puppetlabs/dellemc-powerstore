require 'uri'
require 'json'

module Puppet::Transport
  # The main connection class to a Device endpoint
  class Powerstore
    attr_reader :connection_info

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
    end

    # Shared methods

    def to_query(hash)
      if hash
        return_value = hash.map { |x, v| "#{x}=#{v}" }.reduce { |x, v| "#{x}&#{v}" }
        return return_value unless return_value.nil?
      end
      ''
    end

    def authenticate(_path_params, _query_params, _header_params, _body_params)
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
      hash.each { |x, v| request[x] = v } if hash
      @auth_headers.each { |x, v| request[x] = v } if @auth_headers
    end

    def call_op(path_params, query_params, header_params, body_params, operation_path, operation_verb, parent_consumes)
      uri_string = "#{connection_info[:schema]}://#{connection_info[:host]}:#{connection_info[:port]}#{connection_info[:base_path]}#{operation_path}" % path_params
      if !query_params['query_string'].nil?
        uri_string = uri_string + '?' + query_params['query_string']
      else
        if operation_verb == 'Get' # && operation_path.include?('query')
          query_params['select'] = '*'
        end
        uri_string = uri_string + '?' + to_query(query_params) unless query_params.empty?
      end
      header_params['Content-Type'] = parent_consumes
      # FIXME: this always requests the first 2000 pages of results, might be better to implement dynamic pagination based on 206 HTTP return code.
      header_params['Range'] = '0-2000'
      verify_mode = OpenSSL::SSL::VERIFY_NONE

      return unless authenticate(path_params, query_params, header_params, body_params)
      Puppet.info('Authentication succeeded')

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
      if operation_verb != 'Get' && body_params
        req.body = body_params.key?('file_content') ? body_params['file_content'] : body_params.to_json
      end
      Puppet.debug("URI is (#{operation_verb}) #{uri}, body is #{body_params}, query params are #{query_params}, headers are #{header_params}")
      http.start do
        response = http.request req # Net::HTTPResponse object
        Puppet.debug("response code is #{response.code} and body is #{response.body}")
        success = response.is_a? Net::HTTPSuccess
        Puppet.info("Called (#{operation_verb}) endpoint at #{uri}, success was #{success}")
        return response unless response.code == '206' # we received a partial response
        body = []
        loop do
          body += JSON.parse(response.body)
          m = response['content-range'].match %r{(?<from>\d+)-(?<to>\d+)/(?<total>\d+)}
          range_to = m['to'].to_i
          range_total = m['total'].to_i
          break if range_to + 1 >= range_total
          req['Range'] = "#{range_to + 1}-#{range_to + 2000}"
          response = http.request req
        end
        response.body = body.to_json
        return response
      end
    end

    # FIXME: facts not implemented
    # @summary
    #   Returns device's facts
    def facts(_context)
      {
        'fact1' => 'value1',
      }
    end

    def verify(context)
      # FIXME: not implemented
      # Test that transport can talk to the remote target
    end

    def close(_context)
      # FIXME: not implemented
      # Close connection, free up resources
    end
  end
end
