# frozen_string_literal: true

module RsApi
  class PlayerExperienceTest
    include SkillHelper

    RSpec.describe PlayerExperience do
      let(:player) { described_class.new(player_name) }

      it 'returns PlayerNotFound' do
        unknown_name = 'unknown'
        erb = { player_name: unknown_name }

        VCR.use_cassette('hiscores/player_experience__not_found', erb:) do
          service = described_class.new(unknown_name)
          error = RsApi::RsRequest::PlayerNotFound
          expect { service.raw_data }.to raise_error(error)
        end
      end

      it 'returns ServiceUnavailable' do
        unavailable_name = 'unavailable'
        erb = { player_name: unavailable_name }

        # I need to allow repeats because when RsRequest gets ServiceUnavailable it retries
        VCR.use_cassette('hiscores/player_experience__service_unavailable', erb:, allow_playback_repeats: true) do
          service = described_class.new(unavailable_name)
          error = RsApi::RsRequest::ServiceUnavailable
          expect { service.raw_data }.to raise_error(error)
        end
      end

      it 'displays PlayerNotFound' do
        unknown_name = 'unknown'
        erb = { player_name: unknown_name }

        # I need to allow playback repeats because `raw_data` has no data
        VCR.use_cassette('hiscores/player_experience__not_found', erb:, allow_playback_repeats: true) do
          service = described_class.new(unknown_name)

          # Can something else help test text from puts?
          expect(service.display).to be_nil
          expect { service.display }.not_to raise_error
        end
      end

      it 'sets username' do
        expect(player.player_name).to eq(player_name)
      end

      context 'when request successful' do
        it 'loads xp' do
          VCR.use_cassette('hiscores/player_experience__successful', erb: { player_name: }) do
            player_xp = player.raw_data

            expect(player_xp.class).to eq(Array)
            expect(player_xp.length).to eq(SKILL_ID_CONST.length)
            # expect fixture here
          end
        end

        it 'formats experience' do
          VCR.use_cassette('hiscores/player_experience__successful', erb: { player_name: }) do
            table = player.display

            # confirm experience value is formatted with .delimited
            expect(table.rows.last[3]).to include(',').at_least(:once)
          end
        end

        it 'displays player\'s exp' do
          VCR.use_cassette('hiscores/player_experience__successful', erb: { player_name: }) do
            # Can something else help test text from puts?
            expect { player.display }.not_to raise_error
            expect(player.display).to be_instance_of(Text::Table)
          end
        end

        it 'returns player\'s highest level' do
          VCR.use_cassette('hiscores/player_experience__successful', erb: { player_name: }) do
            max = player.max_skill_level

            expect(max.class).to eq(String)
            expect(max).to eq('111')
          end
        end

        it 'returns all skills at player\'s highest level' do
          VCR.use_cassette('hiscores/player_experience__successful', erb: { player_name: }) do
            skills_at_max = player.skills_at_max_level

            expect(skills_at_max.class).to eq(Array)
            expect(skills_at_max).to eq(['Invention'])
            expect(skills_at_max.length).to eq(1)
          end
        end

        it 'returns player\'s experience in all skills' do
          VCR.use_cassette('hiscores/player_experience__successful', erb: { player_name: }) do
            all_xp = player.all_skill_experience

            expect(all_xp.class).to eq(Array)
            expect(all_xp[0].class).to eq(Integer)
            expect(all_xp.length).to eq(SKILL_ID_CONST.length)
          end
        end
      end

      def player_name
        'tibthedragon'
      end
    end
  end
end
