require 'puppet'
require 'json'

# Sets up the transport for a remote task
class TaskHelper
  attr_reader :debug_statements
  attr_accessor :target

  def initialize
    unless Puppet.settings.global_defaults_initialized?
      # Puppet.initialize_settings
      # FIXME: debugging support
      Puppet.initialize_settings(['--confdir', '/etc/puppetlabs/puppet/puppet.conf'])
    end
    @transport = {}
  end

  class Error < RuntimeError
    attr_reader :kind, :details, :issue_code

    def initialize(msg, kind, details = nil)
      super(msg)
      @kind = kind
      @issue_code = issue_code
      @details = details || {}
    end

    def to_h
      { 'kind' => kind,
        'msg' => message,
        'details' => details }
    end
  end

  def debug(statement)
    @debug_statements ||= []
    @debug_statements << statement
  end

  def transport_name
    @transport_name ||= target[:'remote-transport']
  end

  def transport
    begin
      require 'puppet/resource_api/transport'
    rescue LoadError
      require 'puppet_x/puppetlabs/panos/transport_shim'
    end

    @transport[transport_name] ||= Puppet::ResourceApi::Transport.connect(transport_name, credentials)
  end

  def credentials
    @credentials ||= target.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }
  end

  def task(params = {})
    msg = 'The task author must implement the `task` method in the task'
    raise TaskHelper::Error.new(msg, 'tasklib/not-implemented')
  end


  def self.run
    task = new
    # support debugging by reading command line arguments
    if ARGV.size > 0
      input = ARGV[0]
    else
      input = STDIN.read
    end
    params = walk_keys(JSON.parse(input))
    task.target = params[:'_target']

    add_plugin_paths(params[:'_installdir']) if params.key? :'_installdir'

    result = task.task(params)

    if result.class == Hash
      STDOUT.print JSON.generate(result)
    else
      STDOUT.print result.to_s
    end
  rescue TaskHelper::Error => e
    STDOUT.print({ _error: e.to_h }.to_json)
    exit 1
  rescue StandardError => e
    details = {
      'backtrace' => e.backtrace,
      'debug' => task.debug_statements
    }.compact

    error = TaskHelper::Error.new(e.message, e.class.to_s, details)
    STDOUT.print({ _error: error.to_h }.to_json)
    exit 1
  end

  # Accepts a Data object and returns a copy with all hash keys
  # symbolized.
  def self.walk_keys(data)
    if data.is_a? Hash
      data.each_with_object({}) do |(k, v), acc|
        v = walk_keys(v)
        acc[k.to_sym] = v
      end
    elsif data.is_a? Array
      data.map { |v| walk_keys(v) }
    else
      data
    end
  end

  private

  # Syncs across anything from the module lib
  def self.add_plugin_paths(install_dir)
    Dir.glob(File.join([install_dir, '*'])).each do |mod|
      $LOAD_PATH << File.join([mod, 'lib'])
    end
  end
end
