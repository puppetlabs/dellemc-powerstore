#!/opt/puppetlabs/puppet/bin/ruby

require 'spec_helper_acceptance_local'
require 'bolt_spec/run'

config_data = {
  'modulepath' => "#{__dir__}/../fixtures/modules"
}

inventory_data = YAML.load_file("#{__dir__}/../fixtures/inventory.yaml")

include BoltSpec::Run

describe "powerstore_remote_system" do
  it 'should perform remote_system_collection_query' do
    result = run_task("powerstore::remote_system_collection_query", 'sut', {}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
    expect(result[0]['value']).not_to be_nil
  end
  it 'should perform remote_system_instance_query' do
    result = run_task("powerstore::remote_system_instance_query", 'sut', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform remote_system_delete' do
    result = run_task("powerstore::remote_system_delete", 'sut', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  it 'should perform remote_system_create' do
    result = run_task("powerstore::remote_system_create", 'sut', sample_task_parameters('remote_system_create'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  it 'should perform remote_system_verify' do
    result = run_task("powerstore::remote_system_verify", 'sut', sample_task_parameters('remote_system_verify'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  end
