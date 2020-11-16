#!/opt/puppetlabs/puppet/bin/ruby

require 'spec_helper_acceptance_local'
require 'bolt_spec/run'

config_data = {
  'modulepath' => "#{__dir__}/../fixtures/modules",
}

inventory_data = YAML.load_file("#{__dir__}/../fixtures/inventory.yaml")

include BoltSpec::Run

describe 'powerstore_migration_session' do
  it 'performs migration_session_collection_query' do
    result = run_task('powerstore::migration_session_collection_query', 'sut', {}, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
    expect(result[0]['value']).not_to be_nil
  end

  it 'performs migration_session_instance_query' do
    result = run_task('powerstore::migration_session_instance_query', 'sut', { 'id' => 'string' }, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
    expect(result[0]['value']).not_to be_nil
  end

  it 'performs migration_session_delete' do
    result = run_task('powerstore::migration_session_delete', 'sut', { 'id' => 'string' }, config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
  end

  it 'performs migration_session_create' do
    result = run_task('powerstore::migration_session_create', 'sut', sample_task_parameters('migration_session_create'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
  end

  it 'performs migration_session_cutover' do
    result = run_task('powerstore::migration_session_cutover', 'sut', sample_task_parameters('migration_session_cutover'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
  end

  it 'performs migration_session_pause' do
    result = run_task('powerstore::migration_session_pause', 'sut', sample_task_parameters('migration_session_pause'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
  end

  it 'performs migration_session_resume' do
    result = run_task('powerstore::migration_session_resume', 'sut', sample_task_parameters('migration_session_resume'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
  end

  it 'performs migration_session_sync' do
    result = run_task('powerstore::migration_session_sync', 'sut', sample_task_parameters('migration_session_sync'), config: config_data, inventory: inventory_data)
    expect(result[0]['status']).to eq('success')
  end
end
