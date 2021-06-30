# frozen_string_literal: true

task :rails_mini_profiler do
  desc 'Install rails_mini_profiler'
  task :setup do
    system 'rails g rails_mini_profiler:install'
  end
end
