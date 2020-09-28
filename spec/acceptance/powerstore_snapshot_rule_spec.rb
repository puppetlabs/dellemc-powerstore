require 'spec_helper_acceptance'

describe 'powerstore_snapshot_rule' do
  it 'get snapshot_rule' do
    result = run_resource('powerstore_snapshot_rule', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create snapshot_rule' do
    pp = run_resource('powerstore_snapshot_rule', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete snapshot_rule' do
    pp = <<-EOS
    powerstore_snapshot_rule { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end