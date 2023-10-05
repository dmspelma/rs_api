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
  s.files                 = Dir['{lib}/**/*.rb']
  s.require_paths         = ['lib']
  s.homepage              = 'https://github.com/dmspelma/rs_api'
  s.license               = 'MIT'

  s.add_dependency('text-table', ['~> 1.2', '>= 1.2.4'])

  s.add_development_dependency('rspec', '~> 3.10')
  s.add_development_dependency('webmock', '~> 3.14')
  s.metadata['rubygems_mfa_required'] = 'true'
end
