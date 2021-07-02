# frozen_string_literal: true

namespace :rails_mini_profiler do
  desc 'Install rails_mini_profiler'
  task :install do
    system('rails g rails_mini_profiler:install install')
  end
end
