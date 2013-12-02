# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'where_builder/version'

Gem::Specification.new do |spec|
  spec.name          = "where_builder"
  spec.version       = WhereBuilder::VERSION
  spec.authors       = ["Zhang Dong"]
  spec.email         = ["zdcin@163.com"]
  spec.description   = "a sql where string builder, can ignore nil and black string."
  spec.summary       = "sql where builder"
  spec.homepage      = "http://rubygems.org/gems/where_builder"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
