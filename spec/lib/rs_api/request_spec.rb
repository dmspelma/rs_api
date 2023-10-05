# frozen_string_literal: true

module RsApi
  class RsRequestTest
    RSpec.describe RsRequest do
      let(:request) { described_class.new(url, params) }

      it 'initialize' do
        expect(request.url).not_to be_nil
        expect(request.params.class).to eq(params.class)
      end

      it 'get request successful' do
        full_url = URI(url)
        full_url.query = URI.encode_www_form(params)
        expected_response = { body: SUCCESS_PLAYER_RESPONSE }
        stub_request(:get, full_url).to_return(expected_response)

        response = request.get

        expect(response).not_to be_nil
        expect(response.body).to eq(expected_response[:body])
        expect(response.code).to eq('200')
      end

      def params
        { player: 'player' }
      end

      def url
        'https://secure.runescape.com/m=hiscore/index_lite.ws?'
      end
    end
  end
end
