require 'spec_helper_acceptance'

type_name = 'powerstore_nas_server'

describe type_name do
  it "get #{type_name}"  do
    result = run_resource(type_name)
    expect(result).to match(%r{ensure => 'present'}).or match(%r{Completed get, returning hash \[\]})
  end

  it "create #{type_name}" do
    r = sample_resource(type_name)
    r[:ensure] = 'present'
    pp = manifest_from_values(type_name, r)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  
  it "update #{type_name}" do
    pp = sample_manifest(type_name, true)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
  

  it "delete #{type_name}" do
    r = sample_resource(type_name)
    r[:ensure] = 'absent'
    pp = manifest_from_values(type_name, r)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

end