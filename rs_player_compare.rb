# frozen_string_literal:true

require './rs_player_exp'

module RsApi
  # class PlayerCompare that compares two PlayerExp skill experience.
  class PlayerCompare
    include RSConst

    def initialize(player1, player2)
      @player1 = PlayerExp.new(player1)
      @player2 = PlayerExp.new(player2)
    end

    def compare
      SKILL_ID_CONST.each do |key, skill_name|
        diff = @player1.all_skill_experience[key] - @player2.all_skill_experience[key]
        results << case diff <=> 0
        when -1
          [skill_name, @player2.username, (-diff).delimited]
        when 1
          [skill_name, @player1.username, diff.delimited]
        else # 0
          [skill_name, 'TIE', '0']
        end
      end
    end

    def display
      compare
      table.head = %w[SKILL WINNER XP-DIFFERENCE]
      puts table
    end

    def results
      @results ||= [] # index 0 total exp, rest is normal skills by exp
    end

    private

    def table
      @table ||= Text::Table.new(rows: results, horizontal_padding: 2)
    end
  end
end

# Example
# a = RsApi::PlayerCompare.new('tibthedragon', 'bubba tut')
# a.display
