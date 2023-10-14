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
# require_relative 'rs_player_experience'

module RsApi
  # class PlayerCompare that compares two PlayerExp skill experience.
  class PlayerCompare < Hiscore
    attr_reader :player1, :player2

    def initialize(player1, player2)
      @player1 = PlayerExperience.new(player1)
      @player2 = PlayerExperience.new(player2)
    end

    def compare
      SKILL_ID_CONST.each do |key, skill_name|
        xp_diff = @player1.all_skill_experience[key] - @player2.all_skill_experience[key]

        raw_data << compare_result(key, skill_name, xp_diff)
      end
    end

    def display
      if raw_data.empty?
        compare
        table.head = %w[SKILL WINNER LEVEL XP-DIFFERENCE]
        table.rows = formatted_data
      end

      if display?
        # :nocov:
        colour? ? (puts colour_table) : (puts table)
        # :nocov:
      end
      table
    end

    def raw_data
      @raw_data ||= [] # index 0 is total exp, rest is normal skills by exp
    end

    private

    def capitalize(value)
      value.capitalize
    end

    # :nocov:
    def colour_row(row)
      if row[1] == player1.player_name
        row.map(&:to_s).map(&:blue)
      else
        row.map(&:to_s).map(&:green)
      end
    end

    def colour_table
      c_table = table.dup
      c_table.head = c_table.head.map(&:white)
      c_table.rows = c_table.rows.map { |row| colour_row(row) }

      c_table
    end
    # :nocov:

    def compare_result(key, skill_name, xp_diff)
      case xp_diff <=> 0
      when -1 # p2 has more skill
        [capitalize(skill_name), @player2.player_name, @player2.raw_data[key][1], xp_diff.abs]
      when 1 # p1 has more skill
        [capitalize(skill_name), @player1.player_name, @player1.raw_data[key][1], xp_diff]
      else # 0
        [capitalize(skill_name), 'TIE', @player2.raw_data[key][1], 0]
      end
    end

    def formatted_data
      raw_data.map { |i, j, k, l| [i, j, k, l.delimited] }
    end
  end
end

# Example
# a = RsApi::PlayerCompare.new('tibthedragon', 'bubba tut')
# a.display
