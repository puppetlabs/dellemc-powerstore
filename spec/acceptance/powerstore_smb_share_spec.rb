require 'spec_helper_acceptance'

describe 'powerstore_smb_share' do
  it 'get smb_share' do
    result = run_resource('powerstore_smb_share', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create smb_share' do
    pp = run_resource('powerstore_smb_share', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete smb_share' do
    pp = <<-EOS
    powerstore_smb_share { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end