# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'feature_cop/version'

Gem::Specification.new do |spec|
  spec.name          = "feature_cop"
  spec.version       = FeatureCop::VERSION
  spec.authors       = ["Brett Allred"]
  spec.email         = ["brettallred@gmail.com"]

  spec.summary       = %q{A simple gem for handing feature flagging in ruby}
  spec.description   = %q{A simple gem for handing feature flagging in ruby}
  spec.homepage      = "http://www.github.com/nuvi/feature_cop"
  spec.license       = "MIT"

  spec.required_ruby_version = '> 2.0.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '>= 4.2'
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
