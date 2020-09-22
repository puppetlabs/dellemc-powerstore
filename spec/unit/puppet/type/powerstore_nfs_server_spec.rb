# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_nfs_server'

RSpec.describe 'the powerstore_nfs_server type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_nfs_server)).not_to be_nil
  end
end
