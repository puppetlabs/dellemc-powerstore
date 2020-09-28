require 'spec_helper_acceptance'

describe 'powerstore_policy' do
  it 'get policy' do
    result = run_resource('powerstore_policy', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create policy' do
    pp = run_resource('powerstore_policy', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete policy' do
    pp = <<-EOS
    powerstore_policy { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end