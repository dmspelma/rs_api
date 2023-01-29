# frozen_string_literal:true

module RsApi
  # class PlayerCompare that compares two PlayerExp skill experience.
  class PlayerCompare
    attr_reader :player1, :player2

    include RsConstants

    def initialize(player1, player2)
      @player1 = PlayerExperience.new(player1)
      @player2 = PlayerExperience.new(player2)
    end

    def compare
      SKILL_ID_CONST.each do |key, skill_name|
        diff = @player1.all_skill_experience[key] - @player2.all_skill_experience[key]
        results << case diff <=> 0
        when -1
          [skill_name, @player2.username, -diff]
        when 1
          [skill_name, @player1.username, diff]
        else # 0
          [skill_name, 'TIE', 0]
        end
      end
    end

    def display
      compare if results.empty?
      table.head = %w[SKILL WINNER XP-DIFFERENCE]
      puts table
    end

    def results
      @results ||= [] # index 0 total exp, rest is normal skills by exp
    end

    private

    def formatted_results
      f_result = results.dup
      f_result.each_with_index do |result, _i|
        result[2] = result[2].delimited
      end
      f_result
    end

    def table
      @table ||= Text::Table.new(rows: formatted_results, horizontal_padding: 2)
    end
  end
end

# Example
# a = RsApi::PlayerCompare.new('tibthedragon', 'bubba tut')
# a.display
