module RailsMiniProfiler
  class Engine < ::Rails::Engine
    isolate_namespace RailsMiniProfiler

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
