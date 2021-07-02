# frozen_string_literal: true

require 'inline_svg'

module RailsMiniProfiler
  class Engine < ::Rails::Engine
    isolate_namespace RailsMiniProfiler

    rake_tasks do
      Dir[File.join(File.dirname(__FILE__), '../tasks/*.rake')].each { |f| load f }
    end

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

    rake_tasks do
      path = File.expand_path(__dir__)
      puts path
      Dir.glob("#{path}/tasks/*.rake").each { |f| load f }
    end
  end
end
