# -*- encoding: utf-8 -*-
require File.expand_path('../lib/knife-bartender', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["krogerb"]
  gem.email         = ["bryan.kroger@hp.com"]
  gem.description   = %q{Interface to the bartender}
  gem.summary       = %q{Interface to the bartender}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "knife-bartender"
  gem.require_paths = ["lib"]
  gem.version       = HPCS::Knife::Bartender::Version
end
