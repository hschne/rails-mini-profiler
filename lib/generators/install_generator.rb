# frozen_string_literal: true

require 'rails/generators'

module RailsMiniProfiler
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)
    include Generators::Utils::InstanceMethods

    desc 'Install rails-mini-profiler'

    def install
      route("mount RailsMiniProfiler::Engine => '/rails_mini_profiler'")
      template 'initializer.erb', 'config/initializers/rails_admin.rb'
      rake('rails_mini_profiler:install:migrations')
    end
  end
end
