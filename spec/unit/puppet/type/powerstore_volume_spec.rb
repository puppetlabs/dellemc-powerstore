# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_volume'

RSpec.describe 'the powerstore_volume type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_volume)).not_to be_nil
  end
end
