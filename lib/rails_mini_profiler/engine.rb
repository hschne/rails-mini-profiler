# frozen_string_literal: true

module RailsMiniProfiler
  # The Rails Mini Profiler engine
  #
  # Injects a a custom [Middleware] into an existing Rails app to record request profiling information.
  class Engine < ::Rails::Engine
    isolate_namespace RailsMiniProfiler

    initializer 'rails_mini_profiler.add_middleware' do |app|
      app.middleware.use(RailsMiniProfiler::Middleware)
    end

    initializer 'rails_mini_profiler.assets.precompile', group: :all do |app|
      app.config.assets.precompile += %w[rails_mini_profiler.js rails_mini_profiler/application.css]
    end

    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'rails_mini_profiler_add_static assets' do |app|
      app.middleware.insert_before(ActionDispatch::Static, ActionDispatch::Static, "#{root}/public")
    end
  end
end
