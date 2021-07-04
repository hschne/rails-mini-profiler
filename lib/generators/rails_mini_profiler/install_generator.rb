# frozen_string_literal: true

module RailsMiniProfiler
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      desc 'Install rails-mini-profiler'
      def install
        route("mount RailsMiniProfiler::Engine => '/rails_mini_profiler'")
        template 'rails_mini_profiler.rb.erb', 'config/initializers/rails_mini_profiler.rb'
        system('rails rails_mini_profiler:install:migrations')
      end
    end
  end
end
