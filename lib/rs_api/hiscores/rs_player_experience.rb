# frozen_string_literal:true

# Uncomment below to run Example(s) in file. May also need to for other related files.
# require 'text-table'
# require_relative 'hiscore'
# require_relative '../rs_request'
# require_relative '../rs_int_extend'
# require_relative '../rs_constants'

module RsApi
  # Class PlayerExp pulls, from Hiscores, player level/experience in each skill.
  class PlayerExperience < Hiscore
    attr_reader :player_name, :table_results

    def initialize(player_name)
      PlayerNameHelper.check_player_name(player_name)
      @player_name = player_name
    end

    # Pull puts form here, make display return table object
    # Then a print method can be included? or used separately?
    def display
      fill_table_data if table.rows.empty?
      display? ? (p table) : table
    rescue PlayerNotFound
      puts "#{@player_name} does not exist." if display?
    end

    def loaded_xp
      @loaded_xp ||= parsed[0..29]
    end

    def max_skill_level
      # Returns the highest skill level out of all sklls
      loaded_xp[1..].map { |value| value[1].to_i }.max.to_s
    end

    def skills_at_max_level
      # Returns a array containing only skills at max_skill_level
      # SKILL_ID_CONST[i+1] | i is +1 because I don't want to load the overall skill totals
      loaded_xp[1..].filter_map.with_index do |value, i|
        SKILL_ID_CONST[i + 1].to_s.capitalize if value[1] == max_skill_level
      end
    end

    def all_skill_experience
      # Retuns array containing the experience for each skill
      # Index of skills corresponds to RsConst::SKILL_ID_CONST
      loaded_xp.map { |n| n.last.delete(',').to_i }
    end

    private

    def fill_table_data
      table.head = [{ value: "Player: #{player_name}", colspan: 3, align: :center }]

      loaded_xp.each_with_index do |value, i|
        table.rows << if i.zero?
          [SKILL_ID_CONST[i].capitalize, "Total Level: #{value[1]}", "Total Experience: #{format(value[2])}"]
        else
          [SKILL_ID_CONST[i].capitalize, "Level: #{value[1]}", "Experience: #{format(value[2])}"]
        end
      end
    end

    def format(value)
      value.to_i.delimited
    end

    def url
      # Url for Runescape 3's Highscore API
      'https://secure.runescape.com/m=hiscore/index_lite.ws?'
    end

    def parsed
      # Response is in CSV format
      response = RsRequest.new(url, params).get
      raise PlayerNotFound if response.message == 'Not Found'

      response.body.split(/\n/).map { |item| item.split(',') }
    end

    def params
      { player: player_name }
    end
  end
end

# Example
# a = RsApi::PlayerExperience.new('tibthedragon')
# a.display
# puts a.max_skill_level
# puts a.skills_at_max_level
# puts a.all_skill_experience