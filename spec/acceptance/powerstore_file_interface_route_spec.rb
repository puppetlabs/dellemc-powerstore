require 'spec_helper_acceptance'

describe 'powerstore_file_interface_route' do
  it 'get file_interface_route' do
    result = run_resource('powerstore_file_interface_route', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create file_interface_route' do
    pp = run_resource('powerstore_file_interface_route', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete file_interface_route' do
    pp = <<-EOS
    powerstore_file_interface_route { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end