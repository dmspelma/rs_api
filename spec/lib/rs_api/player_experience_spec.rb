# frozen_string_literal: true

module RsApi
  class PlayerExperienceTest
    RSpec.describe 'Initialize RsApi::PlayerExperience class successfully' do
      it 'contains default values' do
        player = PlayerExperience.new('tibthedragon')
        expect(player.username).to eq('tibthedragon')
      end
    end

    # Test PlayerExperience
    RSpec.describe PlayerExperience do
      before do
        @player = PlayerExperience.new('tibthedragon')
        @player.stub(:loaded_xp).and_return(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE)
      end

      it 'Loads xp' do
        player_xp = @player.loaded_xp

        expect(player_xp.class).to eq(Array)
        expect(player_xp.length).to eq(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE.length)
        expect(player_xp[0][2]).to include(',').at_least(:once) # confirm experience value is formatted with .delimited
      end

      it 'Returns player\'s highest level' do
        max = @player.max_skill_level

        expect(max.class).to eq(String)
        expect(max).to eq('107')
      end

      it 'Returns all skills that are at player\'s highest level' do
        skills_at_max = @player.skills_at_max_level

        expect(skills_at_max.class).to eq(Array)
        expect(skills_at_max).to eq(['Dungeoneering'])
        expect(skills_at_max.length).to eq(1)
      end

      it 'Returns player\'s experience in all skills' do
        all_xp = @player.all_skill_experience

        expect(all_xp.class).to eq(Array)
        expect(all_xp[0].class).to eq(Integer)
        expect(all_xp.length).to eq(SUCCESS_PLAYER_PARSED_FORMATTED_RESPONSE.length)
      end

      it 'Returns PlayerNotFound error for non-existant player' do
        unknown_player = RsApi::PlayerExperience.new('unknown')
        unknown_player.stub(:loaded_xp).and_return(RsApi::PlayerExperience::PlayerNotFound)
        e = unknown_player.loaded_xp
        expect(e).to eq(RsApi::PlayerExperience::PlayerNotFound)
      end
    end
  end
end
