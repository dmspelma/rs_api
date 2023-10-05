# frozen_string_literal: true

module RsApi
  class PlayerExperienceTest
    RSpec.describe PlayerExperience do
      let(:player) { described_class.new('tibthedragon') }

      it 'returns PlayerNotFound' do
        unknown_player = RsApi::PlayerExperience.new('unknown')
        unknown_player.stub(:loaded_xp).and_return(RsApi::PlayerExperience::PlayerNotFound)

        expect(unknown_player.loaded_xp).to eq(RsApi::PlayerExperience::PlayerNotFound)
      end

      it 'sets username' do
        player = described_class.new('tibthedragon')
        expect(player.username).to eq('tibthedragon')
      end

      context 'when request successful' do
        it 'loads xp' do
          player.stub(:loaded_xp).and_return(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE)
          player_xp = player.loaded_xp

          expect(player_xp.class).to eq(Array)
          expect(player_xp.length).to eq(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE.length)
        end

        it 'formats experience' do
          player.stub(:loaded_xp).and_return(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE)
          player_xp = player.loaded_xp

          # confirm experience value is formatted with .delimited
          expect(player_xp[0][2]).to include(',').at_least(:once)
        end

        it 'returns player\'s highest level' do
          player.stub(:loaded_xp).and_return(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE)
          max = player.max_skill_level

          expect(max.class).to eq(String)
          expect(max).to eq('107')
        end

        it 'returns all skills at player\'s highest level' do
          player.stub(:loaded_xp).and_return(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE)
          skills_at_max = player.skills_at_max_level

          expect(skills_at_max.class).to eq(Array)
          expect(skills_at_max).to eq(['Dungeoneering'])
          expect(skills_at_max.length).to eq(1)
        end

        it 'returns player\'s experience in all skills' do
          player.stub(:loaded_xp).and_return(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE)
          all_xp = player.all_skill_experience

          expect(all_xp.class).to eq(Array)
          expect(all_xp[0].class).to eq(Integer)
          expect(all_xp.length).to eq(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE.length)
        end
      end
    end
  end
end
