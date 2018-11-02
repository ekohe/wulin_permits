# -*- encoding: utf-8 -*-
require File.expand_path('../lib/wulin_permits/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["ekohe"]
  gem.email         = ["dev@ekohe.com"]
  gem.description   = %q{Permissions management for WulinMaster}
  gem.summary       = %q{Permissions management for WulinMaster}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "wulin_permits"
  gem.require_paths = ["lib"]
  gem.version       = WulinPermits::VERSION

  gem.add_dependency 'wulin_master'
end
