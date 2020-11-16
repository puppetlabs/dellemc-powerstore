# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_vcenter'

RSpec.describe 'the powerstore_vcenter type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_vcenter)).not_to be_nil
  end
end
