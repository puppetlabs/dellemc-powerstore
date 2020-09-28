require 'spec_helper_acceptance'

describe 'powerstore_file_virus_checker' do
  it 'get file_virus_checker' do
    result = run_resource('powerstore_file_virus_checker', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create file_virus_checker' do
    pp = run_resource('powerstore_file_virus_checker', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete file_virus_checker' do
    pp = <<-EOS
    powerstore_file_virus_checker { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end