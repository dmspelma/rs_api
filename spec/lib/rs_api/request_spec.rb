# frozen_string_literal: true

module RsApi
  class RsRequestTest
    RSpec.describe RsRequest do
      let(:request) { described_class.new(url, params('player')) }

      it 'initialize' do
        expect(request.url).not_to be_nil
        expect(request.params).not_to be_nil
      end

      context 'when get' do
        it 'successful' do
          VCR.use_cassette('rs_request__success') do
            response = request.get

            expect(response).not_to be_nil
            expect(response.code).to eq('200')
          end
        end

        it 'error: player not found' do
          not_found_name = 'not found'
          erb = { player_name: not_found_name }
          VCR.use_cassette('rs_request__player_not_found', erb:) do
            service = described_class.new(url, params(not_found_name))

            expect { service.get }.to raise_error player_not_found_error
          end
        end

        it 'error: service unavailable' do
          unavailable_name = 'unavailable'
          erb = { player_name: unavailable_name }
          VCR.use_cassette('rs_request__service_unavailable', erb:, allow_playback_repeats: true) do
            service = described_class.new(url, params(unavailable_name))

            expect { service.get }.to raise_error service_unavailable_error
          end
        end
      end

      def params(name)
        { player: name }
      end

      def player_not_found_error
        RsApi::RsRequest::PlayerNotFound
      end

      def service_unavailable_error
        RsApi::RsRequest::ServiceUnavailable
      end

      def url
        'https://secure.runescape.com/m=hiscore/index_lite.ws?'
      end
    end
  end
end
