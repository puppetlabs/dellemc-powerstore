# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_policy'

RSpec.describe 'the powerstore_policy type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_policy)).not_to be_nil
  end
end
