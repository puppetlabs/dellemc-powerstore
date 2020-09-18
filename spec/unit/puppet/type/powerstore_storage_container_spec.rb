# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_storage_container'

RSpec.describe 'the powerstore_storage_container type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_storage_container)).not_to be_nil
  end
end
