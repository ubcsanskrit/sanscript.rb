# frozen_string_literal: true
# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sanscript/version"

Gem::Specification.new do |spec|
  spec.name          = "sanscript"
  spec.version       = Sanscript::VERSION
  spec.authors       = ["Tim Bellefleur"]
  spec.email         = ["nomoon@phoebus.ca"]

  spec.summary       = "Ruby port and extension of Sanscript.js transliterator by learnsanskrit.org"
  spec.homepage      = "https://github.com/ubcsanskrit/sanscript.rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = "~> 2.2"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 11.2"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.6"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "benchmark-ips", "~> 2.6"
  spec.add_development_dependency "yard", "~> 0.9"

  spec.add_runtime_dependency "ice_nine", "~> 0.11"
end
