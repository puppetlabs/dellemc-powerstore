# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_file_ftp'

RSpec.describe 'the powerstore_file_ftp type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_file_ftp)).not_to be_nil
  end
end
