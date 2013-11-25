# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tms_client/version"

Gem::Specification.new do |s|
  s.name        = "tms_client"
  s.version     = TMS::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["GovDelivery"]
  s.email       = ["support@govdelivery.com"]
  s.homepage    = "http://govdelivery.com"
  s.summary     = %q{A ruby client to interact with the GovDelivery TMS REST API.}
  s.description = %q{A reference implementation, written in Ruby, to interact with GovDelivery's TMS API. The client is compatible with Ruby versions 1.8.7 and 1.9.3. }

  if RUBY_VERSION < "1.9"
    s.add_runtime_dependency "json" # this is part of 1.9's stdlib
    s.add_runtime_dependency "activesupport", "~>2.3"
  else
    s.add_runtime_dependency "activesupport"
  end
  
  s.add_runtime_dependency "faraday"
  s.add_runtime_dependency "faraday_middleware"

  s.files       = %w{
    Gemfile
    README.md
    Rakefile
    tms_client.gemspec
  } + Dir["lib/**/*"]

  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end