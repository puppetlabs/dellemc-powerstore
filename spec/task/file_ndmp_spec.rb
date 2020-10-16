#!/opt/puppetlabs/puppet/bin/ruby

require 'spec_helper_acceptance_local'
require 'bolt_spec/run'

config_data = {
  'modulepath' => "#{__dir__}/../fixtures/modules"
}

inventory_data = YAML.load_file("#{__dir__}/../fixtures/inventory.yaml")

include BoltSpec::Run

describe "powerstore_file_ndmp" do
  it 'should perform file_ndmp_collection_query' do
    result = run_task("powerstore::file_ndmp_collection_query", 'prism', {}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']['list']).not_to be_nil  
  end
  it 'should perform file_ndmp_instance_query' do
    result = run_task("powerstore::file_ndmp_instance_query", 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform file_ndmp_delete' do
    result = run_task("powerstore::file_ndmp_delete", 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform file_ndmp_create' do
    result = run_task("powerstore::file_ndmp_create", 'prism', sample_task_parameters('file_ndmp_create'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  end
