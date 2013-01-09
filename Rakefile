require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc 'Open an IRB console with TSMS Client loaded'
task :console do
  exec "irb -I ./lib -r tsms_client"
end