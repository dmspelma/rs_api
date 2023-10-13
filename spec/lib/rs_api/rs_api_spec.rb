# frozen_string_literal: true

module RsApi
  RSpec.describe RsApi do
    let!(:cached_env) { ENV.fetch('RS_API_ENV') }

    before do
      ENV['RS_API_ENV'] = my_env
    end

    after do
      ENV['RS_API_ENV'] = cached_env
    end

    it 'raises error when settings config is missing' do
      my_c_file = "config/settings/#{my_env}.yml"
      error = "Missing configuration file #{my_env}.yml for settings under #{my_c_file}"

      expect { described_class.load_config }.to raise_error(RuntimeError, error)
    end

    def my_env
      'joke'
    end
  end
end
