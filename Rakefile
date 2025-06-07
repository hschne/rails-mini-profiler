# frozen_string_literal: true

require 'bundler/setup'

APP_RAKEFILE = File.expand_path('spec/dummy/Rakefile', __dir__)
load 'rails/tasks/engine.rake'
load 'rails/tasks/statistics.rake'

require 'bundler/gem_tasks'

begin
  require 'rspec/core/rake_task'
  rspec = RSpec::Core::RakeTask.new(:spec)
  rspec.verbose = false
rescue LoadError
  # Not available
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError
  # Not available
end

task lint: %i[rubocop lint:js lint:css lint:commit]
namespace :lint do
  task :js do
    system 'npm run lint'
  end

  task :css do
    system 'npm run lint:scss'
  end

  task :commit do
    system 'npm run lint:commit'
  end
end

task default: %i[spec rubocop]
