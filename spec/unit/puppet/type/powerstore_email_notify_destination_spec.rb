# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/powerstore_email_notify_destination'

RSpec.describe 'the powerstore_email_notify_destination type' do
  it 'loads' do
    expect(Puppet::Type.type(:powerstore_email_notify_destination)).not_to be_nil
  end
end
