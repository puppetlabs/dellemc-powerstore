require 'spec_helper_acceptance'

describe 'powerstore_replication_rule' do
  it 'get replication_rule' do
    result = run_resource('powerstore_replication_rule')
    expect(result).to match(%r{ensure => 'present'}).or match(%r{Completed get, returning hash \[\]})
  end

  it 'create replication_rule' do
    pp = run_resource('powerstore_replication_rule', 'string', false)
    pp.gsub!("string", "string_1")
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  
  it 'update replication_rule' do
    pp = run_resource('powerstore_replication_rule', 'string', false)
    pp.gsub!("=> 'string'", "=> 'string_1'")
    pp.gsub!("=> false", "=> true")
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