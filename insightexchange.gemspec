# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'insightexchange/version'

Gem::Specification.new do |spec|
  spec.name          = "insightexchange"
  spec.version       = InsightExchange::VERSION
  spec.authors       = ["winfred"]
  spec.email         = ["winfred@liberat.us"]
  spec.summary       = %q{This is a tiny wrapper for the InsightExchange.co REST api.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"
end
