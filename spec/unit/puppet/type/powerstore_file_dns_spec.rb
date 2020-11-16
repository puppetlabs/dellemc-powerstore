# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_file_dns'

RSpec.describe 'the powerstore_file_dns type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_file_dns)).not_to be_nil
  end
end
