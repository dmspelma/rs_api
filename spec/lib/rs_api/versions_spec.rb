# frozen_string_literal: true
require 'rs_api/version'

module RsApi
  RSpec.describe do
    it 'Version exists' do
      expect(VERSION).to_not eq(nil)
    end
  end
end
