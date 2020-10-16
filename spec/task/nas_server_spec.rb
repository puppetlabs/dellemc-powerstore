#!/opt/puppetlabs/puppet/bin/ruby

require 'spec_helper_acceptance_local'
require 'bolt_spec/run'

config_data = {
  'modulepath' => "#{__dir__}/../fixtures/modules"
}

inventory_data = YAML.load_file("#{__dir__}/../fixtures/inventory.yaml")

include BoltSpec::Run

describe "powerstore_nas_server" do
  it 'should perform nas_server_collection_query' do
    result = run_task("powerstore::nas_server_collection_query", 'prism', {}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']['list']).not_to be_nil  
  end
  it 'should perform nas_server_instance_query' do
    result = run_task("powerstore::nas_server_instance_query", 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform nas_server_download_group' do
    result = run_task("powerstore::nas_server_download_group", 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform nas_server_download_homedir' do
    result = run_task("powerstore::nas_server_download_homedir", 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform nas_server_download_hosts' do
    result = run_task("powerstore::nas_server_download_hosts", 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform nas_server_download_netgroup' do
    result = run_task("powerstore::nas_server_download_netgroup", 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform nas_server_download_nsswitch' do
    result = run_task("powerstore::nas_server_download_nsswitch", 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform nas_server_download_ntxmap' do
    result = run_task("powerstore::nas_server_download_ntxmap", 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform nas_server_download_passwd' do
    result = run_task("powerstore::nas_server_download_passwd", 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform nas_server_download_user_mapping_report' do
    result = run_task("powerstore::nas_server_download_user_mapping_report", 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform nas_server_delete' do
    result = run_task("powerstore::nas_server_delete", 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform nas_server_create' do
    result = run_task("powerstore::nas_server_create", 'prism', sample_task_parameters('nas_server_create'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform nas_server_ping' do
    result = run_task("powerstore::nas_server_ping", 'prism', sample_task_parameters('nas_server_ping'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform nas_server_update_user_mappings' do
    result = run_task("powerstore::nas_server_update_user_mappings", 'prism', sample_task_parameters('nas_server_update_user_mappings'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform nas_server_upload_group' do
    result = run_task("powerstore::nas_server_upload_group", 'prism', sample_task_parameters('nas_server_upload_group'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform nas_server_upload_homedir' do
    result = run_task("powerstore::nas_server_upload_homedir", 'prism', sample_task_parameters('nas_server_upload_homedir'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform nas_server_upload_hosts' do
    result = run_task("powerstore::nas_server_upload_hosts", 'prism', sample_task_parameters('nas_server_upload_hosts'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform nas_server_upload_netgroup' do
    result = run_task("powerstore::nas_server_upload_netgroup", 'prism', sample_task_parameters('nas_server_upload_netgroup'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform nas_server_upload_nsswitch' do
    result = run_task("powerstore::nas_server_upload_nsswitch", 'prism', sample_task_parameters('nas_server_upload_nsswitch'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform nas_server_upload_ntxmap' do
    result = run_task("powerstore::nas_server_upload_ntxmap", 'prism', sample_task_parameters('nas_server_upload_ntxmap'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform nas_server_upload_passwd' do
    result = run_task("powerstore::nas_server_upload_passwd", 'prism', sample_task_parameters('nas_server_upload_passwd'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  end
