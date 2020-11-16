# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_file_interface'

RSpec.describe 'the powerstore_file_interface type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_file_interface)).not_to be_nil
  end
end
