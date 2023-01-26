# frozen_string_literal:true

require 'net/http'
require 'text-table'
require 'uri'
require 'rs_api/rs_int_extend'

# Base RsApi module for autoloading files
module RsApi
  autoload :RsConstants, 'rs_api/rs_constants'
  autoload :PlayerCompare, 'rs_api/rs_player_compare'
  autoload :PlayerExperience, 'rs_api/rs_player_experience'
  autoload :RsRequest, 'rs_api/rs_request'
end
