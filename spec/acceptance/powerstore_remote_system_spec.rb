require 'spec_helper_acceptance'

describe 'powerstore_remote_system' do
  it 'get remote_system' do
    result = run_resource('powerstore_remote_system', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create remote_system' do
    pp = run_resource('powerstore_remote_system', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete remote_system' do
    pp = <<-EOS
    powerstore_remote_system { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end