require 'spec_helper_acceptance'

describe 'powerstore_smb_server' do
  it 'get smb_server' do
    result = run_resource('powerstore_smb_server', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create smb_server' do
    pp = run_resource('powerstore_smb_server', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete smb_server' do
    pp = <<-EOS
    powerstore_smb_server { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end