# frozen_string_literal: true

module RailsMiniProfiler
  class Engine < ::Rails::Engine
    isolate_namespace RailsMiniProfiler

    initializer 'rails_mini_profiler.add_middleware' do |app|
      app.middleware.use(RailsMiniProfiler::Middleware)
    end

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
