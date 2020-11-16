# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_physical_switch'

RSpec.describe 'the powerstore_physical_switch type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_physical_switch)).not_to be_nil
  end
end
