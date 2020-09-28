require 'spec_helper_acceptance'

describe 'powerstore_file_ftp' do
  it 'get file_ftp' do
    result = run_resource('powerstore_file_ftp', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create file_ftp' do
    pp = run_resource('powerstore_file_ftp', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete file_ftp' do
    pp = <<-EOS
    powerstore_file_ftp { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end