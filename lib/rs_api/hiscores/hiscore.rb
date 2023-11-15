# frozen_string_literal: true

# Uncomment below to run Examples in file. Continue for other related files
# require_relative '../helpers/player_name_helper'
# require_relative '../helpers/skill_helper'

module RsApi
  # Base class for getting Runescape hiscore data for a player
  class Hiscore
    include PlayerNameHelper
    include SkillHelper

    private

    def colour?
      true
      # Settings.colour_output
    end

    def display?
      true
      # Settings.display_output
    end

    def params
      raise 'implement me!'
    end

    def table
      @table ||= Text::Table.new(horizontal_padding: 1)
    end

    def url
      @url ||= 'https://secure.runescape.com/m=hiscore/index_lite.ws?'
    end
  end
end
