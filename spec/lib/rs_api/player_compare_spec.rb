# frozen_string_literal: true

module RsApi
  class PlayerCompareTest
    RSpec.describe PlayerCompare do
      it 'Initializes PlayerCompare' do
        p1 = 'player1'
        p2 = 'player2'
        service = described_class.new(p1, p2)

        expect(service.player1.class).to eq(PlayerExperience)
        expect(service.player2.class).to eq(PlayerExperience)
      end

      describe 'compares players' do
        it 'with same skill xp' do
          compared_players = described_class.new('player1', 'player2')
          compared_players.player1.stub(:loaded_xp).and_return(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE)
          compared_players.player2.stub(:loaded_xp).and_return(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE)
          compared_players.compare

          expect(compared_players.results.length).to eq(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE.length)

          map_of_winners = compared_players.results.map { |result| result[1] }.uniq
          total_xp_diff = compared_players.results.map { |result| result[2] }.sum

          expect(map_of_winners.length).to eq(1)
          expect(map_of_winners.first).to eq('TIE')
          expect(total_xp_diff).to eq(0)
        end

        it 'with different skill xp' do
          compared_players = described_class.new('player1', 'player2')
          p1_results = SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE.dup
          p1_results[0] = %w[1 1 1] # So player2 has more xp in this skill
          p2_results = SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE.dup
          p2_results[1] = %w[1 1 1] # So player1 has more xp in this skill
          compared_players.player1.stub(:loaded_xp).and_return(p1_results)
          compared_players.player2.stub(:loaded_xp).and_return(p2_results)
          compared_players.compare

          map_of_winners = compared_players.results.map { |result| result[1] }.uniq
          total_xp_diff = compared_players.results.map { |result| result[2] }.sum

          expect(compared_players.results.length).to eq(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE.length)
          expect(map_of_winners.length).to eq(3)
          expect(map_of_winners.sort).to eq(%w[TIE player1 player2].sort)
          expect(total_xp_diff).not_to eq(0)
        end

        it 'returns map of arrays' do
          compared_players = described_class.new('player1', 'player2')
          compared_players.player1.stub(:loaded_xp).and_return(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE)
          compared_players.player2.stub(:loaded_xp).and_return(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE)

          compared_players.compare

          expect(compared_players.results.class).to eq(Array)
          expect(compared_players.results.first.class).to eq(Array)
        end
      end
    end
  end
end
