# frozen_string_literal: true

module RailsMiniProfiler
  # Generators for Rails Mini Profiler
  module Generators
    # A basic installation generator to help set up users apps
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      # Install Rails Mini Profiler to your Rails app
      #
      # Updates the routes file to mount the engine, adds an initializer and copies a migration.
      desc 'Install rails-mini-profiler'
      def install
        route("mount RailsMiniProfiler::Engine => '/rails_mini_profiler'")
        template 'rails_mini_profiler.rb.erb', 'config/initializers/rails_mini_profiler.rb'
        system('rails rails_mini_profiler:install:migrations')
      end
    end
  end
end
