# frozen_string_literal:true

require './rs_playerExp'
require './rs_const'
require 'text-table'

module RsApi
  # class Comparator that compares two PlayerExp skill experience.
  class Comparator
    include RSConst

    def initialize(player1, player2)
      @p1 = RsApi::PlayerExp.new(player1)
      @p2 = RsApi::PlayerExp.new(player2)
      results
    end

    def p1_exp
      @p1_exp ||= grab_exp(@p1)
    end

    def p2_exp
      @p2_exp ||= grab_exp(@p2)
    end

    def compare
      SKILL_ID_CONST.length.times do |n|
        if p1_exp[n] > p2_exp[n]
          @results << [SKILL_ID_CONST[n], @p1.username, (p1_exp[n] - p2_exp[n]).to_s(:delimited)]
        else
          @results << [SKILL_ID_CONST[n], @p2.username, (p2_exp[n] - p1_exp[n]).to_s(:delimited)]
        end
      end

      head = %w[SKILL WINNER XP-DIFFERENCE]
      table = Text::Table.new(head: head, rows: @results, horizontal_padding: 2)
      puts table
    end

    def new_players(player1, player2)
      @p1 = RsApi::PlayerExp.new(player1)
      @p2 = RsApi::PlayerExp.new(player2)
      @p1_exp = nil
      @p2_exp = nil
      @results = []
    end

    def results
      @results ||= [] # index 0 total exp, rest is normal skills by exp
    end

    private

    def grab_exp(player)
      player.loaded_xp.map { |n| n.last.delete(',').to_i }
    end
  end
end

# Example
# a = RsApi::Comparator.new('tibthedragon','bubba tut')
# a.compare
# a.new_players('tibthedragon', 'zedifer')
# a.compare
