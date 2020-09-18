# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_replication_rule'

RSpec.describe 'the powerstore_replication_rule type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_replication_rule)).not_to be_nil
  end
end
