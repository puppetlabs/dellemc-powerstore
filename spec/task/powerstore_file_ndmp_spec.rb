#!/opt/puppetlabs/puppet/bin/ruby

require 'spec_helper_acceptance_local'
require 'bolt_spec/run'

config_data = {
  'modulepath' => "#{__dir__}/../fixtures/modules"
}

inventory_data = YAML.load_file("#{__dir__}/../fixtures/inventory.yaml")

include BoltSpec::Run

definition_name = 'powerstore_file_ndmp'

describe "#{definition_name}" do
  it 'should perform file_ndmp_collection_query' do
    task_name = 'powerstore::powerstore_file_ndmp_collection_query'
    result = run_task(task_name, 'prism', {}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  it 'should perform file_ndmp_instance_query' do
    task_name = 'powerstore::powerstore_file_ndmp_instance_query'
    result = run_task(task_name, 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
  end
  it 'should perform file_ndmp_delete' do
    task_name = 'powerstore::powerstore_file_ndmp_delete'
    result = run_task(task_name, 'prism', {"id" => "string"}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')  
	end
  # it 'should create host' do  
  #   result = run_task('powerstore::powerstore_host_create', 'prism', {"body"=>{"name"=>"string"}}, config: config_data,  
  #                   inventory: inventory_data)
  #   puts result
  #   expect(result[0]['status']).to eq('success')  
  # end  

end  
