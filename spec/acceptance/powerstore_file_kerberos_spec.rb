require 'spec_helper_acceptance'

describe 'powerstore_file_kerberos' do
  it 'get file_kerberos' do
    result = run_resource('powerstore_file_kerberos', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create file_kerberos' do
    pp = run_resource('powerstore_file_kerberos', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete file_kerberos' do
    pp = <<-EOS
    powerstore_file_kerberos { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end