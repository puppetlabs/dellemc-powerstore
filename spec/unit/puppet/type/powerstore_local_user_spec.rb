# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_local_user'

RSpec.describe 'the powerstore_local_user type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_local_user)).not_to be_nil
  end
end
