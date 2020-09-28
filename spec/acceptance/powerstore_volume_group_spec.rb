require 'spec_helper_acceptance'

describe 'powerstore_volume_group' do
  it 'get volume_group' do
    result = run_resource('powerstore_volume_group', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create volume_group' do
    pp = run_resource('powerstore_volume_group', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete volume_group' do
    pp = <<-EOS
    powerstore_volume_group { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end