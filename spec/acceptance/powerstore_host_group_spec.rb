require 'spec_helper_acceptance'

describe 'powerstore_host_group' do
  it 'get host_group' do
    result = run_resource('powerstore_host_group', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create host_group' do
    pp = run_resource('powerstore_host_group', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete host_group' do
    pp = <<-EOS
    powerstore_host_group { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end