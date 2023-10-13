# frozen_string_literal:true

# Uncomment below to run Example(s) in file. May also need to for other related files.
# require 'text-table'
# require_relative 'hiscore'
# require_relative '../rs_request'
# require_relative '../rs_int_extend'
# require_relative '../rs_constants'
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
        diff = @player1.all_skill_experience[key] - @player2.all_skill_experience[key]

        results << case diff <=> 0
        when -1 # p2 has more skill
          [capitalize(skill_name), @player2.player_name, diff.abs]
        when 1 # p1 has more skill
          [capitalize(skill_name), @player1.player_name, diff]
        else # 0
          [capitalize(skill_name), 'TIE', 0]
        end
      end
    end

    def display
      if results.empty?
        compare
        table.head = %w[SKILL WINNER XP-DIFFERENCE]
        table.rows = formatted_results
      end
      puts table if display?
    end

    def results
      @results ||= [] # index 0 is total exp, rest is normal skills by exp
    end

    private

    def capitalize(value)
      value.capitalize
    end

    def formatted_results
      results.map { |i, j, k| [i, j, k.delimited] }
    end
  end
end

# Example
# a = RsApi::PlayerCompare.new('tibthedragon', 'bubba tut')
# a.display
