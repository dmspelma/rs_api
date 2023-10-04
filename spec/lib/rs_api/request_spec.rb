# frozen_string_literal: true

module RsApi
  class RsRequestTest
    RSpec.describe RsRequest do
      before do
        @url = URI('https://secure.runescape.com/m=hiscore/index_lite.ws?')
        @params = { player: 'player1' }
        @request = described_class.new(@url, @params)

        @full_url = @url.dup
        @full_url.query = URI.encode_www_form(@params)
      end

      it 'Initializes Request' do
        expect(@request.url).not_to be_nil
        expect(@request.params.class).to eq(Hash)
      end

      it 'Get Request returns response' do
        response = { body: SUCCESS_PLAYER_RESPONSE }
        stub = stub_request(:get, @full_url).to_return(response)

        @request.get
        expect(stub).not_to be_nil
        expect(stub.response.body).to eq(response[:body])
      end
    end
  end
end
