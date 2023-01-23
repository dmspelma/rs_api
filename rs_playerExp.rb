# frozen_string_literal:true

require 'uri'
require 'net/http'
require 'active_support'
require 'active_support/core_ext/numeric/conversions'
require './rs_const'
require 'text-table'

module RsApi
  # Class PlayerExp pulls from Hiscores for player level/exp in each skill.
  class PlayerExp
    attr_accessor :username

    include RSConst

    def initialize(username)
      @username = username
    end

    def display
      loaded_xp

      table = Text::Table.new horizontal_padding: 2
      table.head = [{ value: "Player: #{@username}", colspan: 3, align: :center }]

      title = @loaded_xp[0]
      table.rows << ["#{SKILL_ID_CONST[0]}", "Total Level: #{title[1]}", "Total Experience: #{title[2]}"]
      @loaded_xp[1..-1].each_with_index do |value, i|
        table.rows << ["#{SKILL_ID_CONST[i + 1]}", "Level: #{value[1]}", "Experience: #{value[2]}"]
      end

      puts table
    end

    def change_name(new_name)
      @username = new_name
      @loaded_xp = nil
    end

    def loaded_xp
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get_response(uri)
      parsed = response.body.split(/\n/).map { |item| format(item) }
      @loaded_xp ||= parsed[0..28]
    end

    def max_skill_level
      @max_skill_level = loaded_xp.map { |v| v[1] }.max
    end

    def skills_at_max_level
      # WIP
      @skills_at_max_level = loaded_xp.map { |v| v[0] if v[1] == max_skill_level }
    end

    private

    def format(value)
      value = value.split(',')
      value[2] = value[2].to_i.to_s(:delimited)
      value
    end

    def uri
      @uri ||= URI('https://secure.runescape.com/m=hiscore/index_lite.ws?')
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
