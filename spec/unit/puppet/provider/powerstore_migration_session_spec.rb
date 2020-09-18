# frozen_string_literal: true

require 'spec_helper'

ensure_module_defined('Puppet::Provider::PowerstoreMigration_session')
require 'puppet/provider/powerstore_migration_session/powerstore_migration_session'

RSpec.describe Puppet::Provider::PowerstoreMigration_session::PowerstoreMigration_session do
  subject(:provider) { described_class.new }

  let(:context) { instance_double('Puppet::ResourceApi::BaseContext', 'context') }
  let(:transport) { instance_double('Puppet::Transport::Powerstore', 'transport') }

  before :each do
    response = Net::HTTPSuccess.new(1.0, '200', 'OK')
    allow(context).to receive(:transport).and_return(transport)
    allow(transport).to receive(:call_op).and_return(response)
  end

  # describe '#get' do
  #   it 'processes resources' do
  #     expect(context).to receive(:debug).with('Returning pre-canned example data')
  #     expect(provider.get(context)).to eq [
  #       {
  #         name: 'foo',
  #         ensure: 'present',
  #       },
  #       {
  #         name: 'bar',
  #         ensure: 'present',
  #       },
  #     ]
  #   end
  # end

  describe 'create(context, name, should)' do
    it 'creates the resource' do
      allow(context).to receive(:creating).with("bar").and_yield
      expect(transport).to receive(:call_op).with(any_args, "Post", anything)

      provider.create(context, 'bar', name: 'bar', ensure: 'present')
    end
  end

  

  describe 'delete(context, should)' do
    it 'deletes the resource' do
      expect(transport).to receive(:call_op).with(any_args, "Delete", anything)

      provider.delete(context, {name: 'foo'})
    end
  end
end
