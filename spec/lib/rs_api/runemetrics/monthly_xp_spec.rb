# frozen_string_literal: true

module RsApi
  module MonthlyXpTest
    include SkillHelper

    describe MonthlyXp do
      it 'with invalid name' do
        error = PlayerNameHelper::RsNameInvalid
        expect { described_class.new('tib...dragon') }.to raise_error(error)
      end

      it 'with valid name' do
        expect { described_class.new('tibthedragon') }.not_to raise_error
      end

      describe 'Requesting monthly xp data for player' do
        it 'returns MissingPlayerData' do
          player_name = 'missing'
          VCR.use_cassette('runemetrics/missing_player_data', erb: { player_name: }) do
            service = described_class.new(player_name)
            error = RsApi::MonthlyXp::MissingPlayerData
            expect { service.raw_data }.to raise_error(error)
          end
        end

        it 'returns PlayerNotFound' do
          player_name = 'not found'
          VCR.use_cassette('runemetrics/player_not_found', erb: { player_name: }) do
            service = described_class.new(player_name)
            error = RsApi::RsRequest::PlayerNotFound
            expect { service.raw_data }.to raise_error(error)
          end
        end

        it 'returns ServiceUnavailable' do
          player_name = 'unavailable'
          VCR.use_cassette('runemetrics/service_unavailable', erb: { player_name: }) do
            service = described_class.new(player_name)
            error = RsApi::RsRequest::ServiceUnavailable
            expect { service.raw_data }.to raise_error(error)
          end
        end

        it 'returns monthly xp data' do
          player_name = 'tibthedragon'
          VCR.use_cassette('runemetrics/player_found', erb: { player_name: }) do
            service = described_class.new(player_name)
            data = service.raw_data
            expect { data }.not_to raise_error
            expect(data.class).to eq(Hash)
            expect(data.length).to eq(MONTHLY_XP_SKILL_ID_CONST.length)
            # expect fixture here
          end
        end

        it 'returns previous monthly xp data' do
          player_name = 'tibthedragon'
          VCR.use_cassette('runemetrics/player_found', erb: { player_name: }) do
            service = described_class.new(player_name)
            data = service.previous_monthly_xp_data

            expect { data }.not_to raise_error
            expect(data.class).to eq(Array)
            expect(data.length).to eq(MONTHLY_XP_SKILL_ID_CONST.length)
            # expect fixture here
          end
        end
      end
    end
  end
end
