$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))

require 'jsontodb/version'

Gem::Specification.new do |s|
  s.name        = 'jsontodb'
  s.version     = JSONtoDB::Version::STRING
  s.license     = 'MIT'
  s.authors     = ['Christopher Lutz']
  s.email       = ['lutzblox@gmail.com']

  s.required_ruby_version = '>= 1.9'

  s.files = `git ls-files bin lib LICENSE.txt README.md`.split($RS)
  s.executables << 'jsontodb'

  s.summary     = 'A Ruby library to perform REST requests from the command-line and insert JSON into databases'
  s.homepage    = 'https://github.com/HHS-SpecialTopics/jsontodb'
end
