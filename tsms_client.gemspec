# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tsms_client/version"

Gem::Specification.new do |s|
  s.name        = "tsms_client"
  s.version     = TsmsClient::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["GovDelivery"]
  s.email       = ["support@govdelivery.com"]
  s.homepage    = "http://govdelivery.com"
  s.summary     = %q{A ruby client to interact with the GovDelivery TSMS REST API.}
  s.description = %q{A reference implementation, written in Ruby, to interact with GovDelivery's TSMS API.}

  #s.add_runtime_dependency "foo_gem"
  s.add_runtime_dependency "faraday"
  s.add_development_dependency "rspec"

  s.files       = %w{
    Gemfile
    README.md
    Rakefile
    tsms_client.gemspec
    lib/tsms_client.rb
    lib/tsms_client/version.rb
  }

  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end