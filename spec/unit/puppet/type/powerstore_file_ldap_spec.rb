# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_file_ldap'

RSpec.describe 'the powerstore_file_ldap type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_file_ldap)).not_to be_nil
  end
end
