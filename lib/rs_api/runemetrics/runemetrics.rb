# frozen_string_literal: true

# Uncomment below to run Examples in file. Continue for other related files
# require_relative '../rs_constants'
# require_relative '../helpers/check_valid_player_name.rb'

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

    def params
      raise 'implement me!'
    end

    def url
      raise 'implement me!'
    end
  end
end
