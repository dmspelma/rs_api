# frozen_string_literal:true

require_relative 'lib/rs_api/version'

Gem::Specification.new do |s|
  s.required_ruby_version = '3.1.1.18'
  s.name                  = 'rs_api'
  s.version               = RsApi::VERSION
  s.summary               = ''
  s.description           = 'Code for using player data from Runescape'
  s.authors               = 'Drew Spelman'
  s.email                 = ['drew.spelman@gmail.com', 'thisfoxcodes@gmail.com']
  s.files                 = Dir['{lib}/**/*.rb'] + Dir['{config}/**/*.rb']
  s.require_paths         = ['lib']
  s.homepage              = 'https://github.com/dmspelma/rs_api'
  s.license               = 'MIT'
  s.metadata['rubygems_mfa_required'] = 'true'
end
