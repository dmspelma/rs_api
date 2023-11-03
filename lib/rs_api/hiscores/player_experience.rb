# frozen_string_literal:true

# Uncomment below to run Example(s) in file. May also need to for other related files.
# require 'text-table'
# require_relative 'hiscore'
# require_relative '../rs_request'
# require_relative '../helpers/integer_helper'
# require_relative '../helpers/string_colour_helper'
# require_relative '../helpers/skill_helper'
# require_relative '../patches/text_table__cell_patch' # for color printing
# require_relative '../patches/text_table__table_patch' # for color printing

module RsApi
  # Class PlayerExp pulls, from Hiscores, player level/experience in each skill.
  class PlayerExperience < Hiscore
    attr_reader :player_name, :table_results

    def initialize(player_name)
      PlayerNameHelper.check_player_name(player_name)
      @player_name = player_name
    end

    def display
      fill_table_data if table.rows.empty?
      if display?
        # :nocov:
        colour? ? (puts colour_table) : (puts table)
        # :nocov:
      end
      table
    rescue RsApi::RsRequest::PlayerNotFound
      puts "#{@player_name} does not exist.".red if display?
    end

    def raw_data
      @raw_data ||= parsed[0..29]
    end

    def max_skill_level
      # Returns the highest skill level out of all sklls
      raw_data[1..].map { |value| value[1].to_i }.max.to_s
    end

    def skills_at_max_level
      # Returns a array containing only skills at max_skill_level
      # SKILL_ID_CONST[i+1] | i is +1 because I don't want to load the overall skill totals
      raw_data[1..].filter_map.with_index do |value, i|
        SKILL_ID_CONST[i + 1].to_s.capitalize if value[1] == max_skill_level
      end
    end

    def all_skill_experience
      # Retuns array containing the experience for each skill
      # Index of skills corresponds to RsConst::SKILL_ID_CONST
      raw_data.map { |n| n.last.delete(',').to_i }
    end

    private

    # :nocov:
    def colour_table
      c_table = table.dup
      c_table.head = c_table.head.map(&:white)

      c_table.rows = c_table.rows.map do |row|
        [row[0].to_s.yellow, row[1].red, row[2].cyan, row[3].green]
      end

      c_table
    end
    # :nocov:

    def fill_table_data
      table.head = [player_name, 'Rank', 'Level', 'Experience']

      # Future: move 'Overall' xp info to footer
      raw_data.each_with_index do |value, i|
        table.rows << [SKILL_ID_CONST[i].capitalize, format(value[0]), value[1], format(value[2])]
      end
    end

    def format(value)
      value.to_i.delimited
    end

    def url
      # RsApi.load_config['runescape_urls']['hiscore_url']
      Settings.runescape_urls.hiscore_url
    end

    def parsed
      # Response is in CSV format
      response = RsRequest.new(url, params).get

      response.body.split("\n").map { |item| item.split(',') }
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
