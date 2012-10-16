# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid'
require 'mongoid/oslc/version'

Gem::Specification.new do |gem|
  gem.name          = "mongoid_oslc"
  gem.version       = Mongoid::Oslc::VERSION
  gem.authors       = ["Martin Magnusek"]
  gem.email         = ["magnusekm@gmail.com"]
  gem.description   = %q{Extension for mongoid to parse oslc.where}
  gem.summary       = ""
  gem.homepage      = ""

  gem.add_runtime_dependency 'mongoid', ['<= 4.0', '>= 3.0']
  gem.add_runtime_dependency 'treetop'

  gem.add_development_dependency('rake', ['>= 0.9.2'])
  gem.add_development_dependency('rspec', ['~> 2.8'])

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
