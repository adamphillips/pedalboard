$:.push File.expand_path('../lib', __FILE__)
require 'pedalboard/version'

Gem::Specification.new do |s|
  s.name          = 'pedalboard'
  s.version       = Pedalboard.version
  s.platform      = Gem::Platform::RUBY
  s.date          = '2014-05-04'
  s.summary       = 'Easy Arduino MIDI pedalboard'
  s.description   = 'Quick and easy prototyping for Arduino-based MIDI pedalboards'
  s.authors       = ['Adam Phillips']
  s.email         = 'adam@29ways.co.uk'
  s.homepage      = 'https://github.com/adamphillips/pedalboard'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'dino'
  s.add_runtime_dependency 'micromidi'
  s.add_runtime_dependency 'mixlib-cli'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'codeclimate-test-reporter'
end
