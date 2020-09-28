require 'spec_helper_acceptance'

describe 'powerstore_vcenter' do
  it 'get vcenter' do
    result = run_resource('powerstore_vcenter', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create vcenter' do
    pp = run_resource('powerstore_vcenter', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete vcenter' do
    pp = <<-EOS
    powerstore_vcenter { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end