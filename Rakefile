require 'rspec/core/rake_task'
require 'rubygems/tasks'
require 'rubygems/tasks/scm'
require 'yard'

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
end

RSpec::Core::RakeTask.new(:spec)
Gem::Tasks.new

desc "Run spec with all supported versions of active support"
task :compatibility_spec do
  [2,3,4].each do |n|
    puts `ACTIVE_SUPPORT_VERSION='~> #{n}' bundle ; rake spec`
  end
end

task :default => :spec