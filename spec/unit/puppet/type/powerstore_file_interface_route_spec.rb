# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_file_interface_route'

RSpec.describe 'the powerstore_file_interface_route type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_file_interface_route)).not_to be_nil
  end
end
