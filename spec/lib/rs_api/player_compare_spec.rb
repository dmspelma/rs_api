# frozen_string_literal: true

module RsApi
  class PlayerCompareTest
    include RsConstants

    RSpec.describe PlayerCompare do
      let(:service) { described_class.new(player1, player2) }
      let(:erb) { { player1:, player2: } }

      it 'Initializes PlayerCompare' do
        expect(service.player1.class).to eq(PlayerExperience)
        expect(service.player1.username).to eq('player1')
        expect(service.player2.class).to eq(PlayerExperience)
        expect(service.player2.username).to eq('player2')
      end

      describe 'compares players' do
        it 'with same skill xp' do
          VCR.use_cassette('player_compare__successful__tie', erb:) do
            service.compare

            map_of_winners = service.results.map { |result| result[1] }.uniq
            total_xp_diff = service.results.map { |result| result[2] }.sum

            expect(service.results.length).to eq(SKILL_ID_CONST.length)
            expect(map_of_winners.length).to eq(1)
            expect(map_of_winners.first).to eq('TIE')
            expect(total_xp_diff).to eq(0)
          end
        end

        it 'with different skill xp' do
          VCR.use_cassette('player_compare__successful__different_xp', erb:) do
            service.compare

            map_of_winners = service.results.map { |result| result[1] }.uniq
            total_xp_diff = service.results.map { |result| result[2] }.sum

            expect(service.results.length).to eq(SKILL_ID_CONST.length)
            expect(map_of_winners.length).to eq(3)
            expect(map_of_winners.sort).to eq(%w[TIE player1 player2].sort)
            expect(total_xp_diff).not_to eq(0)
          end
        end

        it 'returns map of arrays' do
          VCR.use_cassette('player_compare__successful__different_xp', erb:) do
            service.compare

            expect(service.results.class).to eq(Array)
            expect(service.results.first.class).to eq(Array)
          end
        end

        it 'displays player xp comparison' do
          VCR.use_cassette('player_compare__successful__different_xp', erb:) do
            # Can something else help test text from puts?
            expect { service.display }.not_to raise_error
            expect(service.display).to be_nil
          end
        end
      end

      def player1
        'player1'
      end

      def player2
        'player2'
      end
    end
  end
end
