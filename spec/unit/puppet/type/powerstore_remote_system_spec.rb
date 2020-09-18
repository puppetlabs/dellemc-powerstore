# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_remote_system'

RSpec.describe 'the powerstore_remote_system type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_remote_system)).not_to be_nil
  end
end
