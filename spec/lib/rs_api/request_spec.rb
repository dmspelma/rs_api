# frozen_string_literal: true

module RsApi
  class RsRequestTest
    RSpec.describe RsRequest do

      before do
        @url = URI('https://secure.runescape.com/m=hiscore/index_lite.ws?')
        @params = { player: 'player1' }
        @request = RsRequest.new(@url, @params)

        @full_url = @url.dup
        @full_url.query = URI.encode_www_form(@params)
      end

      it 'Initializes Request' do
        expect(@request.url).to_not eq(nil)
        expect(@request.params.class).to eq(Hash)
      end

      it 'Get Request returns response' do
        response = { body: SUCCESS_PLAYER_RESPONSE }
        stub = stub_request(:get, @full_url).to_return(response)

        @request.get
        expect(stub).to_not eq(nil)
        expect(stub.response.body).to eq(response[:body])
      end
    end
  end
end
