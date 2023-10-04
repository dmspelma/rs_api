# frozen_string_literal: true

module RsApi
  class PlayerCompareTest
    RSpec.describe 'Initialize RsApi::PlayerCompare Successfully' do
      it 'Initializes PlayerCompare' do
        @player1 = 'player1'
        @player2 = 'player2'
        c = PlayerCompare.new(@player1, @player2)

        expect(c.player1.class).to eq(PlayerExperience)
        expect(c.player2.class).to eq(PlayerExperience)
      end
    end

    # Test PlayerCompare
    RSpec.describe PlayerCompare do
      before do
        @compared_players = described_class.new('player1', 'player2')
      end

      it 'Compares two players with equal skill that tie and puts answer the in `results`' do
        @compared_players.player1.stub(:loaded_xp).and_return(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE)
        @compared_players.player2.stub(:loaded_xp).and_return(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE)
        @compared_players.compare

        expect(@compared_players.results).not_to be_nil
        expect(@compared_players.results.length).to eq(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE.length)

        map_of_winners = @compared_players.results.map { |result| result[1] }.uniq
        total_xp_diff = @compared_players.results.map { |result| result[2] }.sum

        expect(@compared_players.results.class).to eq(Array)
        expect(@compared_players.results.first.class).to eq(Array)
        expect(map_of_winners.length).to eq(1)
        expect(map_of_winners.first).to eq('TIE')
        expect(total_xp_diff).to eq(0)
      end

      it 'Compares two players with different skill and puts answer the in `results`' do
        p1_results = SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE.dup
        p1_results[0] = %w[1 1 1] # So player2 has more xp in this skill
        p2_results = SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE.dup
        p2_results[1] = %w[1 1 1] # So player1 has more xp in this skill
        @compared_players.player1.stub(:loaded_xp).and_return(p1_results)
        @compared_players.player2.stub(:loaded_xp).and_return(p2_results)
        @compared_players.compare

        expect(@compared_players.results).not_to be_nil
        expect(@compared_players.results.length).to eq(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE.length)

        map_of_winners = @compared_players.results.map { |result| result[1] }.uniq
        total_xp_diff = @compared_players.results.map { |result| result[2] }.sum

        expect(@compared_players.results.class).to eq(Array)
        expect(@compared_players.results.first.class).to eq(Array)
        expect(map_of_winners.length).to eq(3)
        expect(map_of_winners.sort).to eq(%w[TIE player1 player2].sort)
        expect(total_xp_diff).not_to eq(0)
      end
    end
  end
end
