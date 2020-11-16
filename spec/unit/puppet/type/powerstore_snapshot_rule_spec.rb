# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_snapshot_rule'

RSpec.describe 'the powerstore_snapshot_rule type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_snapshot_rule)).not_to be_nil
  end
end
