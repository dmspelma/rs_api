# frozen_string_literal:true

require 'active_support/inflector'
require 'config'
require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'json'
require 'net/http'
require 'text-table'
require 'uri'
require 'yaml'
require_relative 'rs_api/patches/integer'
require_relative 'rs_api/patches/string'
require_relative 'rs_api/patches/text_table__cell_patch'
require_relative 'rs_api/patches/text_table__table_patch'

# Base RsApi module for autoloading files
module RsApi
  def self.autoload_files(*sub_dir)
    sub_dir.each do |s|
      Dir[File.join(__dir__, 'rs_api', s.to_s, '*.rb')].each do |file|
        class_name = File.basename(file, '.rb').camelcase
        autoload class_name, file
      end
    end
  end

  Config.setup do |config|
    env = ENV['RS_API_ENV'] || 'development'

    # Set preferred settings
    config.const_name = 'Settings'
    config.evaluate_erb_in_yaml = true

    # Load Settings
    config.load_and_set_settings(Config.setting_files('config', env))
  end
end

RsApi.autoload_files(:helpers, :hiscores, :runemetrics, '')
