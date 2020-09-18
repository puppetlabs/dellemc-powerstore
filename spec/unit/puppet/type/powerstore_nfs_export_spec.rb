# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_nfs_export'

RSpec.describe 'the powerstore_nfs_export type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_nfs_export)).not_to be_nil
  end
end
