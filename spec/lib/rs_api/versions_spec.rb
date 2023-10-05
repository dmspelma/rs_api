# frozen_string_literal: true

require 'rs_api/version'

module RsApi
  RSpec.describe 'RsApi version' do
    it 'Version exists' do
      expect(VERSION).not_to be_nil
    end
  end
end
