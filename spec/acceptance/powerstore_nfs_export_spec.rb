require 'spec_helper_acceptance'

describe 'powerstore_nfs_export' do
  it 'get nfs_export' do
    result = run_resource('powerstore_nfs_export')
    expect(result).to match(%r{ensure => 'present'}).or match(%r{Completed get, returning hash \[\]})
  end

  it 'create nfs_export' do
    pp = run_resource('powerstore_nfs_export', 'string', false)
    pp.gsub!("string", "string_1")
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  
  it 'update nfs_export' do
    pp = run_resource('powerstore_nfs_export', 'string', false)
    pp.gsub!("=> 'string'", "=> 'string_1'")
    pp.gsub!("=> false", "=> true")
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end


  it 'delete nfs_export' do
    pp = <<-EOS
    powerstore_nfs_export { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end