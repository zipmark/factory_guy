# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'factory_guy/version'

Gem::Specification.new do |spec|
  spec.name          = "factory_guy"
  spec.version       = FactoryGuy::VERSION
  spec.authors       = ["Matt Campbell"]
  spec.email         = ["matt@zipmark.com"]

  spec.summary       = %q{Like Factory Girl, but lighter and smaller.}
  spec.description   = %q{Don't think too much about it. Just use it if you were thinking of using Fatory Girl in a Rails project.}
  spec.homepage      = "https://github.com/zipmark/factory_guy"
  spec.license       = "MIT"

  spec.files         = Dir.glob("{bin,lib}/**/*") + %w(LICENSE.txt README.md CODE_OF_CONDUCT.md)
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rails", ">= 4.2"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10"
end
