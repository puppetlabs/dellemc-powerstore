require 'spec_helper_acceptance'

describe 'powerstore_physical_switch' do
  it 'get physical_switch' do
    result = run_resource('powerstore_physical_switch', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create physical_switch' do
    pp = run_resource('powerstore_physical_switch', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete physical_switch' do
    pp = <<-EOS
    powerstore_physical_switch { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end