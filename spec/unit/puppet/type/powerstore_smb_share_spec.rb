# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_smb_share'

RSpec.describe 'the powerstore_smb_share type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_smb_share)).not_to be_nil
  end
end
