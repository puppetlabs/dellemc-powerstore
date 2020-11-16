# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_file_nis'

RSpec.describe 'the powerstore_file_nis type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_file_nis)).not_to be_nil
  end
end
