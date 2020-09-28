require 'spec_helper_acceptance'

describe 'powerstore_file_ndmp' do
  it 'get file_ndmp' do
    result = run_resource('powerstore_file_ndmp', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create file_ndmp' do
    pp = run_resource('powerstore_file_ndmp', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete file_ndmp' do
    pp = <<-EOS
    powerstore_file_ndmp { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end