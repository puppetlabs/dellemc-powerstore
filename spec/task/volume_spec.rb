#!/opt/puppetlabs/puppet/bin/ruby

require 'spec_helper_acceptance_local'
require 'bolt_spec/run'

config_data = {
  'modulepath' => "#{__dir__}/../fixtures/modules",
}

inventory_data = YAML.load_file("#{__dir__}/../fixtures/inventory.yaml")

include BoltSpec::Run

describe 'powerstore_volume' do
  it 'performs volume_collection_query' do
    result = run_task('powerstore::volume_collection_query', 'sut', {}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
    expect(result[0]['value']).not_to be_nil
  end

  it 'performs volume_instance_query' do
    result = run_task('powerstore::volume_instance_query', 'sut', { 'id' => 'string' }, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
    expect(result[0]['value']).not_to be_nil
  end

  it 'performs volume_delete' do
    result = run_task('powerstore::volume_delete', 'sut', { 'id' => 'string' }, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
  end

  it 'performs volume_create' do
    result = run_task('powerstore::volume_create', 'sut', sample_task_parameters('volume_create'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
  end

  it 'performs volume_attach' do
    result = run_task('powerstore::volume_attach', 'sut', sample_task_parameters('volume_attach'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
  end

  it 'performs volume_clone' do
    result = run_task('powerstore::volume_clone', 'sut', sample_task_parameters('volume_clone'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
  end

  it 'performs volume_detach' do
    result = run_task('powerstore::volume_detach', 'sut', sample_task_parameters('volume_detach'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
  end

  it 'performs volume_refresh' do
    result = run_task('powerstore::volume_refresh', 'sut', sample_task_parameters('volume_refresh'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
  end

  it 'performs volume_restore' do
    result = run_task('powerstore::volume_restore', 'sut', sample_task_parameters('volume_restore'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
  end

  it 'performs volume_snapshot' do
    result = run_task('powerstore::volume_snapshot', 'sut', sample_task_parameters('volume_snapshot'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
  end
end
