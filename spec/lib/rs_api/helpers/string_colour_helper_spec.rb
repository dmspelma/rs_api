# frozen_string_literal: true

module RsApi
  class StringColourHelperTest
    RSpec.describe String do
      let(:my_string) { 'Hello World!' }

      it 'is terminal negative' do
        expect(my_string.negative).to eq("\033[7mHello World!\033[0m")
      end

      it 'is terminal black' do
        expect(my_string.black).to eq("\033[1;30;47mHello World!\033[0m")
      end

      it 'is terminal red' do
        expect(my_string.red).to eq("\033[31mHello World!\033[0m")
      end

      it 'is terminal green' do
        expect(my_string.green).to eq("\033[32mHello World!\033[0m")
      end

      it 'is terminal yellow' do
        expect(my_string.yellow).to eq("\033[33mHello World!\033[0m")
      end

      it 'is terminal blue' do
        expect(my_string.blue).to eq("\033[34mHello World!\033[0m")
      end

      it 'is terminal purple' do
        expect(my_string.purple).to eq("\033[35mHello World!\033[0m")
      end

      it 'is terminal cyan' do
        expect(my_string.cyan).to eq("\033[36mHello World!\033[0m")
      end

      it 'is terminal white' do
        expect(my_string.white).to eq("\033[37mHello World!\033[0m")
      end
    end
  end
end
