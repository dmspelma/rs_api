# frozen_string_literal:true

require 'uri'
require 'net/http'
require 'active_support'
require 'active_support/core_ext/numeric/conversions'
require './lib/rs_const'
require 'text-table'

module RsApi
  # Class PlayerExp pulls from Hiscores for player level/exp in each skill.
  class PlayerExp
    attr_reader :username

    include RSConst

    def initialize(username)
      @username = username
    end

    def display
      table.head = [{ value: "Player: #{@username}", colspan: 3, align: :center }]

      loaded_xp.each_with_index do |value, i|
        if i.zero?
          ["#{SKILL_ID_CONST[i]}", "Total Level: #{value[1]}", "Total Experience: #{value[2]}"] # rubocop:disable Style/RedundantInterpolation
        else
          table.rows << ["#{SKILL_ID_CONST[i]}", "Level: #{value[1]}", "Experience: #{value[2]}"] # rubocop:disable Style/RedundantInterpolation
        end
      end

      puts table
    end

    def loaded_xp
      @loaded_xp ||= parsed[0..28]
    end

    def max_skill_level
      loaded_xp.map { |v| v[1] }.max
    end

    def skills_at_max_level
      loaded_xp.filter_map.with_index { |v, i| SKILL_ID_CONST[i] if v[1] == max_skill_level }
    end

    private

    def table
      @table ||= Text::Table.new horizontal_padding: 2
    end

    def format(value)
      value = value.split(',')
      value[2] = value[2].to_i.to_s(:delimited)
      value
    end

    def uri
      @uri ||= URI('https://secure.runescape.com/m=hiscore/index_lite.ws?')
    end

    def parsed
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get_response(uri)
      response.body.split(/\n/).map { |item| format(item) }
    end

    def params
      { player: @username }
    end
  end
end

# Example
# a = RsApi::PlayerExp.new('zedifer')
# a.display
# puts a.max_skill_level
# puts a.skills_at_max_level
