require 'spec_helper_acceptance'

describe 'powerstore_file_ldap' do
  it 'get file_ldap' do
    result = run_resource('powerstore_file_ldap', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create file_ldap' do
    pp = run_resource('powerstore_file_ldap', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete file_ldap' do
    pp = <<-EOS
    powerstore_file_ldap { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end