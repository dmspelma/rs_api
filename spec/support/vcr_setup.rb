# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  # the directory where your cassettes will be saved
  c.cassette_library_dir = 'spec/vcr_cassettes'
  # your HTTP request service.
  c.hook_into :webmock

  # Leaving this here, because this can help when debugging
  # c.debug_logger = $stderr
end
