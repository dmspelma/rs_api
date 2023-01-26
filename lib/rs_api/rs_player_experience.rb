# frozen_string_literal:true

module RsApi
  # Class PlayerExp pulls from Hiscores for player level/exp in each skill.
  class PlayerExperience
    class PlayerNotFound < StandardError; end
    attr_reader :username

    include RsConstants

    def initialize(username)
      @username = username
    end

    def display
      table_data if table.rows.empty?
      puts table
    end

    def loaded_xp
      @loaded_xp ||= parsed[0..28]
    end

    def max_skill_level
      # Returns the highest skill level out of all sklls
      loaded_xp[1..].map { |value| value[1].to_i }.max.to_s
    end

    def skills_at_max_level
      # Returns a array containing only skills at max_skill_level
      loaded_xp[1..].filter_map.with_index { |value, i| SKILL_ID_CONST[i] if value[1] == max_skill_level }
    end

    def all_skill_experience
      # Retuns array containing the experience for each skill
      # Index of skills corresponds to RsConst::SKILL_ID_CONST
      loaded_xp.map { |n| n.last.delete(',').to_i }
    end

    private

    def table
      @table ||= Text::Table.new(horizontal_padding: 2)
    end

    def table_data
      table.head = [{ value: "Player: #{@username}", colspan: 3, align: :center }]

      loaded_xp.each_with_index do |value, i|
        table.rows << if i.zero?
          [SKILL_ID_CONST[i], "Total Level: #{value[1]}", "Total Experience: #{value[2]}"]
        else
          [SKILL_ID_CONST[i], "Level: #{value[1]}", "Experience: #{value[2]}"]
        end
      end
    end

    def format(value)
      value = value.split(',')
      value[2] = value[2].to_i.delimited
      value
    end

    def hiscore_url
      # Url for Runescape's Highscore API
      'https://secure.runescape.com/m=hiscore/index_lite.ws?'
    end

    def parsed
      # Response is in CSV format
      response = RsRequest.new(hiscore_url, params).get
      raise PlayerNotFound if response.message == 'Not Found'

      response.body.split(/\n/).map { |item| format(item) }
    rescue StandardError => e
      puts "#{e.message} | Please check Username spelling."
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
