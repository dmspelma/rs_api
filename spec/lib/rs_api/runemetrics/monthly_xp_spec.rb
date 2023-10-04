# frozen_string_literal: true

module RsApi
  module RsMonthlyXpTest
    include RsConstants

    describe RsMonthlyXp do
      it 'with invalid name' do
        error = RsApi::CheckValidPlayerName::RsNameInvalid
        expect { RsMonthlyXp.new('tib...dragon') }.to raise_error(error)
      end

      it 'with valid name' do
        expect { RsMonthlyXp.new('tibthedragon') }.to_not raise_error
      end
    end

    describe 'Requesting monthly xp data for player' do
      it 'returns MissingPlayerData' do
        player_name = 'missing'
        VCR.use_cassette('runemetrics/missing_player_data', erb: { player_name: }) do
          service = RsMonthlyXp.new(player_name)
          error = RsApi::RsMonthlyXp::MissingPlayerData
          expect { service.raw_data }.to raise_error(error)
        end
      end

      it 'returns PlayerNotFound' do
        player_name = 'not found'
        VCR.use_cassette('runemetrics/player_not_found', erb: { player_name: }) do
          service = RsMonthlyXp.new(player_name)
          error = RsApi::RsMonthlyXp::PlayerNotFound
          expect { service.raw_data }.to raise_error(error)
        end
      end

      it 'returns monthly xp data for all skills' do
        player_name = 'tibthedragon'
        VCR.use_cassette('runemetrics/player_found', erb: { player_name: }) do
          service = RsMonthlyXp.new(player_name)
          data = service.raw_data
          expect { data }.to_not raise_error
          expect(data.class).to eq(Hash)
          expect(data.length).to eq(MONTHLY_XP_SKILL_ID_CONST.length)
        end
      end
    end
  end
end
