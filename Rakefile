require 'rspec/core/rake_task'
require 'rubygems/tasks'
require 'rubygems/tasks/scm'
require 'yard'

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
end

RSpec::Core::RakeTask.new(:spec)
Gem::Tasks.new

task :default => :spec