# frozen_string_literal:true

# Uncomment below to run Examples in file. Continue for other related files
# require '../rs_request'
# require '../rs_constants'
# require '../helpers/check_valid_player_name.rb'

module RsApi
  # For obtaining monthly xp data for a user.
  class MonthlyXp < Runemetrics
    class PlayerNotFound < StandardError; end
    class MissingPlayerData < StandardError; end

    def raw_data
      @raw_data ||= request_all_data
    end

    private

    def missing_player_data
      MissingPlayerData.new('Player data is missing.')
    end

    def player_not_found
      PlayerNotFound.new('Player doesn\'t exist.')
    end

    def request_all_data
      puts 'Processing request. Please wait...' if display?
      data = {}
      sum_total_gain_xp = 0

      MONTHLY_XP_SKILL_ID_CONST.each do |skill_id, skill_name|
        parsed_response = monthly_xp_request(skill_id)

        data[skill_name] = parsed_response
        sum_total_gain_xp += data[skill_name]['totalGain']
      end

      raise missing_player_data if sum_total_gain_xp.zero?

      data
    end

    def monthly_xp_request(skill_id)
      response = RsRequest.new(url, params(skill_id)).get
      raise player_not_found if response.body == ''

      JSON.parse(response.body)['monthlyXpGain'].first
    end

    def params(skill_id)
      { searchName: @player, skillid: skill_id }
    end

    def url
      'https://apps.runescape.com/runemetrics/xp-monthly'
    end
  end
end

# Example:
# a = RsApi::RuneMetrics::MonthlyXp.new('tibthedragon..')
# p a.raw_data
