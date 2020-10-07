require 'spec_helper_acceptance'

type_name = 'powerstore_file_interface'

describe type_name do
  it "get #{type_name}"  do
    result = run_resource(type_name)
    expect(result).to match(%r{ensure => 'present'}).or match(%r{Completed get, returning hash \[\]})
  end

  it "create #{type_name}" do
    r = sample_resource(type_name, ensure: :present)
    pp = manifest_from_values(type_name, r)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  
  it "update #{type_name}", :update do
    namevars_value = 'string' if ENV["MOCK_ACCEPTANCE"]
    r = sample_resource(type_name, ensure: :present, namevars_value: namevars_value)
    pp = manifest_from_values(type_name, r)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
  

  it "delete #{type_name}" do
    namevars_value = 'string' if ENV["MOCK_ACCEPTANCE"]
    r = sample_resource(type_name, ensure: :absent, namevars_value: namevars_value)
    pp = manifest_from_values(type_name, r)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

end
