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
        webpacker_install if defined?(Webpacker::Engine)
      end

      private

      def webpacker_install
        webpacker_config_file = Rails.root.join('config', 'webpacker.yml')
        unless File.exist?(webpacker_config_file)
          say "Webpacker is not installed. Run 'rails webpacker:install' and rerun installation to complete setup"
          return
        end

        run 'yarn add @rails-mini-profiler/assets'
        webpack_config = YAML.load_file(webpacker_config_file)[Rails.env]
        destination = Rails.root.join(webpack_config['source_path'],
                                      webpack_config['source_entry_path'],
                                      'rails-mini-profiler.js')
        template('rails_mini_profiler.js.erb', destination)
      end
    end
  end
end
