require_relative "lib/wulin_permits/version"

Gem::Specification.new do |s|
  s.name = "wulin_permits"
  s.version = WulinPermits::VERSION
  s.authors = ["Ekohe"]
  s.email = ["dev@ekohe.com"]
  s.homepage = "https://gitlab.ekohe.com/ekohe/wulin/wulin_permits"
  s.summary = "Permissions management for WulinMaster"
  s.description = "Role, privilege and permission management for WulinMaster apps, with automatic permission checks on screens."
  s.license = "MIT"

  s.files = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

  s.required_ruby_version = ">= 3.4"

  s.add_dependency "rails", ">= 8.1"
  s.add_dependency "wulin_master"
end
