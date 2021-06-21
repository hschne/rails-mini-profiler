# frozen_string_literal: true

require 'inline_svg'

module RailsMiniProfiler
  class Engine < ::Rails::Engine
    isolate_namespace RailsMiniProfiler

    initializer 'rails_mini_profiler.add_middleware' do |app|
      app.middleware.use(RailsMiniProfiler::Middleware)
    end

    initializer 'rails_mini_profiler.assets.precompile' do |app|
      app.config.assets.precompile += %w[rails_mini_profiler.js]
    end

    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'rails_mini_profiler_add_static assets' do |app|
      app.middleware.insert_before(ActionDispatch::Static, ActionDispatch::Static, "#{root}/public")
    end

    initializer :append_migrations do |app|
      app.config.paths['db/migrate'] += config.paths['db/migrate'].expanded unless app.root.to_s.match root.to_s
    end
  end
end
