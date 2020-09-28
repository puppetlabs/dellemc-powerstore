require 'spec_helper_acceptance'

describe 'powerstore_file_nis' do
  it 'get file_nis' do
    result = run_resource('powerstore_file_nis', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create file_nis' do
    pp = run_resource('powerstore_file_nis', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete file_nis' do
    pp = <<-EOS
    powerstore_file_nis { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end