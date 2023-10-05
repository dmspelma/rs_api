# frozen_string_literal: true

module RsApi
  # Functions for helping with Runescape player names
  module PlayerNameHelper
    class RsNameInvalid < StandardError; end

    def self.check_player_name(player_name)
      raise player_name_invalid_error unless valid_player_name(player_name)
    end

    class << self
      private

      def valid_player_name(player_name)
        (player_name =~ /^[a-zA-Z0-9\s]{1,12}$/)&.zero?
      end

      def player_name_invalid_error
        RsNameInvalid.new('Please enter a 1-12 character alphanumeric name')
      end
    end
  end
end
