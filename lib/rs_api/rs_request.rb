# frozen_string_literal:true

# Uncomment below to run Examples in file. Continue for other related files
# require 'uri'
# require 'net/http'

module RsApi
  # Class RsRequest that handles any Rs Api request
  class RsRequest
    class PlayerNotFound < StandardError; end
    class ServiceUnavailable < StandardError; end

    MAX_RETRIES = 2

    attr_reader :url, :params

    def initialize(url, params = {})
      @url = url
      @params = params
    end

    def get
      uri.query = URI.encode_www_form(@params)
      response = Net::HTTP.get_response(uri)

      check_for_errors(response)
      response
    rescue ServiceUnavailable
      retries ||= 0
      raise ServiceUnavailable, response.code if retries >= MAX_RETRIES

      retries += 1
      retry
    end

    def put; end

    private

    def check_for_errors(response)
      raise PlayerNotFound, response.code if response.code == '404' && response.message == 'Not Found'
      raise ServiceUnavailable, response.code if response.code == '302' && response[:location] == unavailable_url
    end

    def unavailable_url
      'https://www.runescape.com/unavailable'
    end

    def uri
      @uri ||= URI(@url)
    end
  end
end

# Example
# a = RsApi::RsRequest.new('https://secure.runescape.com/m=hiscore/index_lite.ws?', { player: 'tibthedragon' })
# puts a.get.response.body
