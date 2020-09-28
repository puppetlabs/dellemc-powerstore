require 'spec_helper_acceptance'

describe 'powerstore_email_notify_destination' do
  it 'get email_notify_destination' do
    result = run_resource('powerstore_email_notify_destination', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create email_notify_destination' do
    pp = run_resource('powerstore_email_notify_destination', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete email_notify_destination' do
    pp = <<-EOS
    powerstore_email_notify_destination { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end