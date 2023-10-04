# frozen_string_literal: true

module RsApi
  module CheckValidPlayerNameTest
    RSpec.describe CheckValidPlayerName do
      it 'raises RsNameInvalid for invalid names' do
        invalid_names = [
          '',
          nil,
          'superduperlongname',
          'axol.lotle',
          '2,n,e,1'
        ]
        error = RsApi::CheckValidPlayerName::RsNameInvalid
        error_msg = 'Please enter a 1-12 character alphanumeric name'

        invalid_names.each do |player_name|
          expect { described_class.check_player_name(player_name) }.to raise_error(error, error_msg)
        end
      end

      it 'returns nil if name is valid' do
        valid_names = [
          'tibthedragon',
          'bubba tut',
          '2ne1',
          '123 abc w',
          'X'
        ]

        valid_names.each do |player_name|
          expect(described_class.check_player_name(player_name)).to be_nil
        end
      end
    end
  end
end
