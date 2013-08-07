# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'terebi/version'

Gem::Specification.new do |gem|
  gem.name          = "terebi"
  gem.version       = Terebi::VERSION
  gem.authors       = ["Bill Mers"]
  gem.email         = ["b@mers.me"]
  gem.description   = "iTunes automation."
  gem.summary       = "Automates some iTunes library stuff I got tired of doing by hand."
  gem.homepage      = "http://www.github.com/billmers/terebi"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = ["terebi"]
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "thor", "~> 0.18"

  gem.add_development_dependency "minitest", "~> 5"
  gem.add_development_dependency "rake", "~> 10"
  gem.add_development_dependency "awesome_print", "~> 1.1"
end
