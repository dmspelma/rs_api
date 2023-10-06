# frozen_string_literal: true

module RsApi
  class RunemetricsTest
    RSpec.describe Runemetrics do
      let(:service) { described_class.new(player) }

      it 'initializes' do
        expect(service.player).to eq('player name')
      end

      it 'has default params' do
        expect(service.send(:params)).to eq({})
      end

      it 'has default url' do
        expect(service.send(:url)).to eq('implement me!')
      end

      def player
        'player name'
      end
    end
  end
end
