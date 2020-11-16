# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_host_group'

RSpec.describe 'the powerstore_host_group type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_host_group)).not_to be_nil
  end
end
