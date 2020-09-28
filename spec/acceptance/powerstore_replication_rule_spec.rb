require 'spec_helper_acceptance'

describe 'powerstore_replication_rule' do
  it 'get replication_rule' do
    result = run_resource('powerstore_replication_rule', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create replication_rule' do
    pp = run_resource('powerstore_replication_rule', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete replication_rule' do
    pp = <<-EOS
    powerstore_replication_rule { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end