# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_host'

RSpec.describe 'the powerstore_host type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_host)).not_to be_nil
  end
end
