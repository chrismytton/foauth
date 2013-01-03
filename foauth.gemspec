# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'foauth/version'

Gem::Specification.new do |gem|
  gem.name          = "foauth"
  gem.version       = Foauth::VERSION
  gem.authors       = ["Chris Mytton"]
  gem.email         = ["self@hecticjeff.net"]
  gem.description   = %q{foauth.org ruby client}
  gem.summary       = %q{Transparently make authenticated API requests via foauth.org}
  gem.homepage      = "https://github.com/hecticjeff/foauth"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'faraday', '>= 0.8'
  gem.add_development_dependency 'rspec', '>= 2.11'
end
