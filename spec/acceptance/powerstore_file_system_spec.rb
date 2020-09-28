require 'spec_helper_acceptance'

describe 'powerstore_file_system' do
  it 'get file_system' do
    result = run_resource('powerstore_file_system', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create file_system' do
    pp = run_resource('powerstore_file_system', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete file_system' do
    pp = <<-EOS
    powerstore_file_system { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end