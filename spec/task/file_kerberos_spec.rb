#!/opt/puppetlabs/puppet/bin/ruby

require 'spec_helper_acceptance_local'
require 'bolt_spec/run'

config_data = {
  'modulepath' => "#{__dir__}/../fixtures/modules"
}

inventory_data = YAML.load_file("#{__dir__}/../fixtures/inventory.yaml")

include BoltSpec::Run

describe "powerstore_file_kerberos" do
  it 'should perform file_kerberos_collection_query' do
    result = run_task("powerstore::file_kerberos_collection_query", 'prism', {}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']['list']).not_to be_nil  
  end
  it 'should perform file_kerberos_instance_query' do
    result = run_task("powerstore::file_kerberos_instance_query", 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform file_kerberos_download_keytab' do
    result = run_task("powerstore::file_kerberos_download_keytab", 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform file_kerberos_delete' do
    result = run_task("powerstore::file_kerberos_delete", 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform file_kerberos_create' do
    result = run_task("powerstore::file_kerberos_create", 'prism', sample_task_parameters('file_kerberos_create'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform file_kerberos_upload_keytab' do
    result = run_task("powerstore::file_kerberos_upload_keytab", 'prism', sample_task_parameters('file_kerberos_upload_keytab'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  end
