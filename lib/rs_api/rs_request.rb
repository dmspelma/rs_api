# frozen_string_literal:true

module RsApi
  # Class RsRequest that handles any Rs Api request
  class RsRequest
    def initialize(uri, params)
      @uri = URI(uri)
      @params = params
    end

    def get
      @uri.query = URI.encode_www_form(@params)
      Net::HTTP.get_response(@uri)
    end

    def put; end
  end
end
