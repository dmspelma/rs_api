# frozen_string_literal:true

# Uncomment below to run Examples in file. Continue for other related files
# require 'uri'
# require 'net/http'

module RsApi
  # Class RsRequest that handles any Rs Api request
  class RsRequest
    attr_reader :url, :params

    def initialize(url, params = {})
      @url = URI(url)
      @params = params
    end

    def get
      @url.query = URI.encode_www_form(@params)
      Net::HTTP.get_response(@url)
    end

    def put; end
  end
end

# Example
# a = RsApi::RsRequest.new('https://secure.runescape.com/m=hiscore/index_lite.ws?', { player: 'tibthedragon' })
# puts a.get.response.body
