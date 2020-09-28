require 'spec_helper_acceptance'

describe 'powerstore_file_dns' do
  it 'get file_dns' do
    result = run_resource('powerstore_file_dns', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create file_dns' do
    pp = run_resource('powerstore_file_dns', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete file_dns' do
    pp = <<-EOS
    powerstore_file_dns { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end