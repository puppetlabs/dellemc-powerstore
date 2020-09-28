require 'spec_helper_acceptance'

describe 'powerstore_file_interface' do
  it 'get file_interface' do
    result = run_resource('powerstore_file_interface', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create file_interface' do
    pp = run_resource('powerstore_file_interface', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete file_interface' do
    pp = <<-EOS
    powerstore_file_interface { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end