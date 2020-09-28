require 'spec_helper_acceptance'

describe 'powerstore_nas_server' do
  it 'get nas_server' do
    result = run_resource('powerstore_nas_server', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create nas_server' do
    pp = run_resource('powerstore_nas_server', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete nas_server' do
    pp = <<-EOS
    powerstore_nas_server { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end