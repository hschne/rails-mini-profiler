# frozen_string_literal: true

require 'importmap-rails'
require 'turbo-rails'
require 'stimulus-rails'

module RailsMiniProfiler
  # The Rails Mini Profiler engine
  #
  # Injects a a custom [Middleware] into an existing Rails app to record request profiling information.
  class Engine < ::Rails::Engine
    isolate_namespace RailsMiniProfiler

    initializer 'rails_mini_profiler.add_middleware' do |app|
      app.middleware.use(RailsMiniProfiler::Middleware)
    end

    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'rails_mini_profiler_add_static assets' do |app|
      app.middleware.insert_before(ActionDispatch::Static, ActionDispatch::Static, "#{root}/public")
    end

    initializer 'rails_mini_profiler.assets' do |app|
      app.config.assets.paths << root.join('app/assets/stylesheets')
      app.config.assets.paths << root.join('app/javascript')
      app.config.assets.precompile += %w[rails_mini_profiler_manifest
                                         rails_mini_profiler/rails-mini-profiler.css
                                         rails_mini_profiler/application.js]
    end

    initializer 'rails_mini_profiler.importmap', after: 'importmap' do |app|
      RailsMiniProfiler.importmap.draw(root.join('config/importmap.rb'))
      if app.config.importmap.sweep_cache && app.config.reloading_enabled?
        RailsMiniProfiler.importmap.cache_sweeper(watches: root.join('app/javascript'))

        ActiveSupport.on_load(:action_controller_base) do
          before_action { RailsMiniProfiler.importmap.cache_sweeper.execute_if_updated }
        end
      end
    end
  end
end
