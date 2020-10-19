#!/opt/puppetlabs/puppet/bin/ruby

require 'spec_helper_acceptance_local'
require 'bolt_spec/run'

config_data = {
  'modulepath' => "#{__dir__}/../fixtures/modules"
}

inventory_data = YAML.load_file("#{__dir__}/../fixtures/inventory.yaml")

include BoltSpec::Run

describe "powerstore_file_system" do
  it 'should perform file_system_collection_query' do
    result = run_task("powerstore::file_system_collection_query", 'sut', {}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']['list']).not_to be_nil  
  end
  it 'should perform file_system_instance_query' do
    result = run_task("powerstore::file_system_instance_query", 'sut', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform file_system_delete' do
    result = run_task("powerstore::file_system_delete", 'sut', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform file_system_create' do
    result = run_task("powerstore::file_system_create", 'sut', sample_task_parameters('file_system_create'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform file_system_clone' do
    result = run_task("powerstore::file_system_clone", 'sut', sample_task_parameters('file_system_clone'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform file_system_refresh' do
    result = run_task("powerstore::file_system_refresh", 'sut', sample_task_parameters('file_system_refresh'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform file_system_refresh_quota' do
    result = run_task("powerstore::file_system_refresh_quota", 'sut', sample_task_parameters('file_system_refresh_quota'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform file_system_restore' do
    result = run_task("powerstore::file_system_restore", 'sut', sample_task_parameters('file_system_restore'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform file_system_snapshot' do
    result = run_task("powerstore::file_system_snapshot", 'sut', sample_task_parameters('file_system_snapshot'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  end
