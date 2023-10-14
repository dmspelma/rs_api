# frozen_string_literal:true

require 'json'
require 'net/http'
require 'text-table'
require 'uri'
require 'yaml'
require_relative 'rs_api/helpers/integer_helper'
require_relative 'rs_api/helpers/string_colour_helper'
require_relative 'rs_api/patches/text_table__cell_patch'
require_relative 'rs_api/patches/text_table__table_patch'
require_relative 'rs_api/version'

# Base RsApi module for autoloading files
module RsApi
  autoload :SkillHelper, 'rs_api/helpers/skill_helper'
  autoload :PlayerCompare, 'rs_api/hiscores/rs_player_compare'
  autoload :PlayerExperience, 'rs_api/hiscores/rs_player_experience'
  autoload :Hiscore, 'rs_api/hiscores/hiscore'
  autoload :RsRequest, 'rs_api/rs_request'
  autoload :PlayerNameHelper, 'rs_api/helpers/player_name_helper'
  autoload :Runemetrics, 'rs_api/runemetrics/runemetrics'
  autoload :MonthlyXp, 'rs_api/runemetrics/monthly_xp'

  def self.load_config
    env = ENV['RS_API_ENV'] || 'development'
    config_file = File.join('config', 'settings', "#{env}.yml")

    raise "Missing configuration file #{env}.yml for settings under #{config_file}" unless File.exist?(config_file)

    YAML.load_file(config_file)
  end
end
