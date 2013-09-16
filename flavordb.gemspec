# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flavordb/version'

Gem::Specification.new do |spec|
  spec.name          = "flavordb-ruby"
  spec.version       = Flavordb::VERSION
  spec.authors       = ["Michael North"]
  spec.email         = ["michael.north@truenorthapps.com"]
  spec.description   = %q{A ruby client for the FlavorDB API}
  spec.summary       = %q{An awesome object-oriented way of working with beer, wine and whiskey data}
  spec.homepage      = "http://developers.flavordb.com/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
