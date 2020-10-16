#!/opt/puppetlabs/puppet/bin/ruby

require 'spec_helper_acceptance_local'
require 'bolt_spec/run'

config_data = {
  'modulepath' => "#{__dir__}/../fixtures/modules"
}

inventory_data = YAML.load_file("#{__dir__}/../fixtures/inventory.yaml")

include BoltSpec::Run

describe "powerstore_volume" do
  it 'should perform volume_collection_query' do
    result = run_task("powerstore::volume_collection_query", 'prism', {}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']['list']).not_to be_nil  
  end
  it 'should perform volume_instance_query' do
    result = run_task("powerstore::volume_instance_query", 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform volume_delete' do
    result = run_task("powerstore::volume_delete", 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform volume_create' do
    result = run_task("powerstore::volume_create", 'prism', sample_task_parameters('volume_create'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform volume_attach' do
    result = run_task("powerstore::volume_attach", 'prism', sample_task_parameters('volume_attach'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform volume_clone' do
    result = run_task("powerstore::volume_clone", 'prism', sample_task_parameters('volume_clone'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform volume_detach' do
    result = run_task("powerstore::volume_detach", 'prism', sample_task_parameters('volume_detach'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform volume_refresh' do
    result = run_task("powerstore::volume_refresh", 'prism', sample_task_parameters('volume_refresh'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform volume_restore' do
    result = run_task("powerstore::volume_restore", 'prism', sample_task_parameters('volume_restore'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform volume_snapshot' do
    result = run_task("powerstore::volume_snapshot", 'prism', sample_task_parameters('volume_snapshot'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  end
