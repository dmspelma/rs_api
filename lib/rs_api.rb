# frozen_string_literal:true

require 'json'
require 'net/http'
require 'text-table'
require 'uri'
require_relative 'rs_api/rs_int_extend'
require_relative 'rs_api/version'

# Base RsApi module for autoloading files
module RsApi
  autoload :RsConstants, 'rs_api/rs_constants'
  autoload :PlayerCompare, 'rs_api/rs_player_compare'
  autoload :PlayerExperience, 'rs_api/rs_player_experience'
  autoload :RsRequest, 'rs_api/rs_request'
  autoload :PlayerNameHelper, 'rs_api/helpers/player_name_helper'
  autoload :Runemetrics, 'rs_api/runemetrics/rs_runemetrics'
  autoload :RsMonthlyXp, 'rs_api/runemetrics/rs_monthly_xp'
end
