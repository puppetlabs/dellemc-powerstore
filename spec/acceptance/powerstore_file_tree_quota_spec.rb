require 'spec_helper_acceptance'

describe 'powerstore_file_tree_quota' do
  it 'get file_tree_quota' do
    result = run_resource('powerstore_file_tree_quota', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create file_tree_quota' do
    pp = run_resource('powerstore_file_tree_quota', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete file_tree_quota' do
    pp = <<-EOS
    powerstore_file_tree_quota { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end