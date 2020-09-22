# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_file_tree_quota'

RSpec.describe 'the powerstore_file_tree_quota type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_file_tree_quota)).not_to be_nil
  end
end
