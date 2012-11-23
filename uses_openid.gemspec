# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uses_openid/version'

Gem::Specification.new do |gem|
  gem.name          = "uses_openid"
  gem.version       = UsesOpenID::VERSION
  gem.authors       = ["Daniel Vandersluis"]
  gem.email         = ["dvandersluis@selfmgmt.com"]
  gem.description   = %q{Adds some OpenID authentication methods to an ActiveRecord model}
  gem.summary       = %q{Adds some OpenID authentication methods to an ActiveRecord model}
  gem.homepage      = "https://github.com/talentnest/uses_openid"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "activerecord", "> 3.0.0"
  gem.add_dependency "activesupport", "> 3.0.0"
  gem.add_dependency "railties", "> 3.0.0"
end
