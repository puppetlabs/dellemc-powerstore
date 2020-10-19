#!/opt/puppetlabs/puppet/bin/ruby

require 'spec_helper_acceptance_local'
require 'bolt_spec/run'

config_data = {
  'modulepath' => "#{__dir__}/../fixtures/modules"
}

inventory_data = YAML.load_file("#{__dir__}/../fixtures/inventory.yaml")

include BoltSpec::Run

describe "powerstore_import_session" do
  it 'should perform import_session_collection_query' do
    result = run_task("powerstore::import_session_collection_query", 'sut', {}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']['list']).not_to be_nil  
  end
  it 'should perform import_session_instance_query' do
    result = run_task("powerstore::import_session_instance_query", 'sut', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
    expect(result[0]['value']).not_to be_nil  
  end
  it 'should perform import_session_delete' do
    result = run_task("powerstore::import_session_delete", 'sut', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform import_session_create' do
    result = run_task("powerstore::import_session_create", 'sut', sample_task_parameters('import_session_create'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform import_session_cancel' do
    result = run_task("powerstore::import_session_cancel", 'sut', sample_task_parameters('import_session_cancel'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform import_session_cleanup' do
    result = run_task("powerstore::import_session_cleanup", 'sut', sample_task_parameters('import_session_cleanup'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform import_session_cutover' do
    result = run_task("powerstore::import_session_cutover", 'sut', sample_task_parameters('import_session_cutover'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform import_session_pause' do
    result = run_task("powerstore::import_session_pause", 'sut', sample_task_parameters('import_session_pause'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  it 'should perform import_session_resume' do
    result = run_task("powerstore::import_session_resume", 'sut', sample_task_parameters('import_session_resume'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  end
