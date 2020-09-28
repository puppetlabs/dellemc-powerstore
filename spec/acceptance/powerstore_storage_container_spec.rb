require 'spec_helper_acceptance'

describe 'powerstore_storage_container' do
  it 'get storage_container' do
    result = run_resource('powerstore_storage_container', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create storage_container' do
    pp = run_resource('powerstore_storage_container', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete storage_container' do
    pp = <<-EOS
    powerstore_storage_container { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end