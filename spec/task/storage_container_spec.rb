#!/opt/puppetlabs/puppet/bin/ruby

require 'spec_helper_acceptance_local'
require 'bolt_spec/run'

config_data = {
  'modulepath' => "#{__dir__}/../fixtures/modules"
}

inventory_data = YAML.load_file("#{__dir__}/../fixtures/inventory.yaml")

include BoltSpec::Run

describe "powerstore_storage_container" do
  it 'should perform storage_container_collection_query' do
    result = run_task("powerstore::storage_container_collection_query", 'sut', {}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
    expect(result[0]['value']).not_to be_nil
  end
  it 'should perform storage_container_instance_query' do
    result = run_task("powerstore::storage_container_instance_query", 'sut', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform storage_container_delete' do
    result = run_task("powerstore::storage_container_delete", 'sut', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  it 'should perform storage_container_create' do
    result = run_task("powerstore::storage_container_create", 'sut', sample_task_parameters('storage_container_create'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  it 'should perform storage_container_mount' do
    result = run_task("powerstore::storage_container_mount", 'sut', sample_task_parameters('storage_container_mount'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  it 'should perform storage_container_unmount' do
    result = run_task("powerstore::storage_container_unmount", 'sut', sample_task_parameters('storage_container_unmount'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  end
