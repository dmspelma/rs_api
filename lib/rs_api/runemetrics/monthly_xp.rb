# frozen_string_literal:true

# Uncomment below to run Examples in file. Continue for other related files
# require 'json'
# require '../rs_request'
# require '../helpers/skill_helper'
# require_relative 'runemetrics'

module RsApi
  # For obtaining monthly xp data for a user.
  class MonthlyXp < Runemetrics
    class MissingPlayerData < StandardError; end

    # def display; end

    def raw_data
      @raw_data ||= request_all_data
    end

    private

    def request_all_data
      puts 'Processing request. Please wait...'.yellow if display?
      data = {}
      sum_total_gain_xp = 0

      MONTHLY_XP_SKILL_ID_CONST.each do |skill_id, skill_name|
        puts "Collecting #{skill_name} data...".yellow if display?
        parsed_response = monthly_xp_request(skill_id)

        data[skill_name] = parsed_response
        sum_total_gain_xp += data[skill_name]['totalGain']
      end

      raise MissingPlayerData, 'Player data is empty.' if sum_total_gain_xp.zero?

      data
    end

    def monthly_xp_request(skill_id)
      response = RsRequest.new(url, params(skill_id)).get

      JSON.parse(response.body)['monthlyXpGain'].first
    end

    def params(skill_id)
      { searchName: player, skillid: skill_id }
    end

    def url
      Settings.runescape_urls.monthly_xp_url
    end
  end
end

# Example:
# a = RsApi::MonthlyXp.new('tibthedragon')
# pp a.raw_data
