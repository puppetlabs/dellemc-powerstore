require 'spec_helper_acceptance'

describe 'powerstore_file_kerberos' do
  it 'get file_kerberos' do
    result = run_resource('powerstore_file_kerberos')
    expect(result).to match(%r{ensure => 'present'}).or match(%r{Completed get, returning hash \[\]})
  end

  it 'create file_kerberos' do
    pp = run_resource('powerstore_file_kerberos', 'string', false)
    pp.gsub!("string", "string_1")
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  
  it 'update file_kerberos' do
    pp = run_resource('powerstore_file_kerberos', 'string', false)
    pp.gsub!("=> 'string'", "=> 'string_1'")
    pp.gsub!("=> false", "=> true")
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