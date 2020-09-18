# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_import_session'

RSpec.describe 'the powerstore_import_session type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_import_session)).not_to be_nil
  end
end
