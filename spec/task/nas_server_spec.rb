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
    result = run_task("powerstore::nas_server_collection_query", 'sut', {}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
    expect(result[0]['value']).not_to be_nil
  end
  it 'should perform nas_server_instance_query' do
    result = run_task("powerstore::nas_server_instance_query", 'sut', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform nas_server_download_group' do
    result = run_task("powerstore::nas_server_download_group", 'sut', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform nas_server_download_homedir' do
    result = run_task("powerstore::nas_server_download_homedir", 'sut', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform nas_server_download_hosts' do
    result = run_task("powerstore::nas_server_download_hosts", 'sut', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform nas_server_download_netgroup' do
    result = run_task("powerstore::nas_server_download_netgroup", 'sut', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform nas_server_download_nsswitch' do
    result = run_task("powerstore::nas_server_download_nsswitch", 'sut', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform nas_server_download_ntxmap' do
    result = run_task("powerstore::nas_server_download_ntxmap", 'sut', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform nas_server_download_passwd' do
    result = run_task("powerstore::nas_server_download_passwd", 'sut', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform nas_server_download_user_mapping_report' do
    result = run_task("powerstore::nas_server_download_user_mapping_report", 'sut', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform nas_server_delete' do
    result = run_task("powerstore::nas_server_delete", 'sut', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  it 'should perform nas_server_create' do
    result = run_task("powerstore::nas_server_create", 'sut', sample_task_parameters('nas_server_create'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  it 'should perform nas_server_ping' do
    result = run_task("powerstore::nas_server_ping", 'sut', sample_task_parameters('nas_server_ping'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  it 'should perform nas_server_update_user_mappings' do
    result = run_task("powerstore::nas_server_update_user_mappings", 'sut', sample_task_parameters('nas_server_update_user_mappings'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  it 'should perform nas_server_upload_group' do
    result = run_task("powerstore::nas_server_upload_group", 'sut', sample_task_parameters('nas_server_upload_group'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  it 'should perform nas_server_upload_homedir' do
    result = run_task("powerstore::nas_server_upload_homedir", 'sut', sample_task_parameters('nas_server_upload_homedir'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  it 'should perform nas_server_upload_hosts' do
    result = run_task("powerstore::nas_server_upload_hosts", 'sut', sample_task_parameters('nas_server_upload_hosts'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  it 'should perform nas_server_upload_netgroup' do
    result = run_task("powerstore::nas_server_upload_netgroup", 'sut', sample_task_parameters('nas_server_upload_netgroup'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  it 'should perform nas_server_upload_nsswitch' do
    result = run_task("powerstore::nas_server_upload_nsswitch", 'sut', sample_task_parameters('nas_server_upload_nsswitch'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  it 'should perform nas_server_upload_ntxmap' do
    result = run_task("powerstore::nas_server_upload_ntxmap", 'sut', sample_task_parameters('nas_server_upload_ntxmap'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  it 'should perform nas_server_upload_passwd' do
    result = run_task("powerstore::nas_server_upload_passwd", 'sut', sample_task_parameters('nas_server_upload_passwd'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  end
