require 'spec_helper_acceptance'

describe 'powerstore_volume' do
  it 'get volume' do
    result = run_resource('powerstore_volume', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create volume' do
    pp = run_resource('powerstore_volume', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete volume' do
    pp = <<-EOS
    powerstore_volume { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end