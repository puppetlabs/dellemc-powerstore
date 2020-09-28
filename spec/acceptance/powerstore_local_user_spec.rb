require 'spec_helper_acceptance'

describe 'powerstore_local_user' do
  it 'get local_user' do
    result = run_resource('powerstore_local_user', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create local_user' do
    pp = run_resource('powerstore_local_user', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete local_user' do
    pp = <<-EOS
    powerstore_local_user { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end