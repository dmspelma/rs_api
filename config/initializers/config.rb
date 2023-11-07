# frozen_string_literal: true

Config.setup do |config|
  env = ENV.fetch('RS_API_ENV', 'development')

  # Set preferred settings
  config.const_name = 'Settings'
  config.evaluate_erb_in_yaml = true

  # Load Settings
  config.load_and_set_settings(Config.setting_files('config', env))
end
