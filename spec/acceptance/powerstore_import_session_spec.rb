require 'spec_helper_acceptance'

describe 'powerstore_import_session' do
  it 'get import_session' do
    result = run_resource('powerstore_import_session', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create import_session' do
    pp = run_resource('powerstore_import_session', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete import_session' do
    pp = <<-EOS
    powerstore_import_session { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end