# frozen_string_literal: true

# Uncomment below to run Examples in file. Continue for other related files
# require_relative '../helpers/skill_helper'
# require_relative '../helpers/player_name_helper'

module RsApi
  # Base class regarding Runescape's Runemetrics API
  class Runemetrics
    include SkillHelper
    include PlayerNameHelper

    attr_reader :player

    def initialize(player_name)
      PlayerNameHelper.check_player_name(player_name)
      @player = player_name
    end

    private

    def display?
      RsApi.load_config['display_output']
    end

    def params
      raise 'implement me!'
    end

    def url
      raise 'implement me!'
    end
  end
end
