# frozen_string_literal: true

module RsApi
  class Hiscore
    RSpec.describe Hiscore do
      let(:service) { described_class.new }

      it 'has default params' do
        expect { service.send(:params) }.to raise_error(RuntimeError, 'implement me!')
      end

      #       it 'has default url' do
      #         expect { service.send(:url) }.to raise_error(RuntimeError, 'implement me!')
      #       end

      it 'gets config settings' do
        expect(service.send(:colour?)).to be true # while manually setting. Plan to remove this.
        expect(service.send(:display?)).to be true # while manually setting. Plan to remove this.
      end
    end
  end
end
