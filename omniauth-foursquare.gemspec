# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth-foursquare/version"

Gem::Specification.new do |s|
  s.name        = "omniauth-foursquare"
  s.version     = Omniauth::Foursquare::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["TODO: Write your name"]
  s.email       = ["TODO: Write your email address"]
  s.homepage    = ""
  s.summary     = %q{an omniauth strategy for foursquare}
  s.description = %q{an omniauth strategy for foursquare}

  s.rubyforge_project = "omniauth-foursquare"
  s.add_dependency 'omniauth', '~> 1.0.0.rc2'
  s.add_dependency 'omniauth-oauth2', '~> 1.0.0.rc2'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
