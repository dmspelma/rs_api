# frozen_string_literal: true

# Uncomment below to run Examples in file. Continue for other related files
# require_relative '../helpers/player_name_helper'
# require_relative '../rs_constants'

module RsApi
  # Base class for getting Runescape hiscore data for a player
  class Hiscore
    class PlayerNotFound < StandardError; end
    include PlayerNameHelper
    include SkillHelper

    private

    def display?
      RsApi.load_config['display_output']
    end

    def params
      raise 'implement me!'
    end

    def table
      @table ||= Text::Table.new(horizontal_padding: 2)
    end

    def url
      raise 'implement me!'
    end
  end
end
