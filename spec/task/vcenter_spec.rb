#!/opt/puppetlabs/puppet/bin/ruby

require 'spec_helper_acceptance_local'
require 'bolt_spec/run'

config_data = {
  'modulepath' => "#{__dir__}/../fixtures/modules",
}

inventory_data = YAML.load_file("#{__dir__}/../fixtures/inventory.yaml")

include BoltSpec::Run

describe 'powerstore_vcenter' do
  it 'performs vcenter_collection_query' do
    result = run_task('powerstore::vcenter_collection_query', 'sut', {}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
    expect(result[0]['value']).not_to be_nil
  end

  it 'performs vcenter_instance_query' do
    result = run_task('powerstore::vcenter_instance_query', 'sut', { 'id' => 'string' }, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
    expect(result[0]['value']).not_to be_nil
  end

  it 'performs vcenter_delete' do
    result = run_task('powerstore::vcenter_delete', 'sut', { 'id' => 'string' }, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
  end

  it 'performs vcenter_create' do
    result = run_task('powerstore::vcenter_create', 'sut', sample_task_parameters('vcenter_create'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
  end
end
