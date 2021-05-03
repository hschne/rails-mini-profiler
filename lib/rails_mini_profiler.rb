# frozen_string_literal: true

require 'forwardable'

require 'rails_mini_profiler/version'

require 'rails_mini_profiler/engine'

require 'rails_mini_profiler/authorization'
require 'rails_mini_profiler/storage/memory'
require 'rails_mini_profiler/configuration'
require 'rails_mini_profiler/profiler_context'
require 'rails_mini_profiler/request_context'
require 'rails_mini_profiler/request'
require 'rails_mini_profiler/response'
require 'rails_mini_profiler/trace'
require 'rails_mini_profiler/guard'
require 'rails_mini_profiler/badge'
require 'rails_mini_profiler/middleware'

module RailsMiniProfiler
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def context
      @context ||= ProfilerContext.instance(configuration)
    end

    def authorize!
      RailsMiniProfiler::Authorization.authorize!
    end

    def current_user=(current_user)
      RailsMiniProfiler::User.current_user = current_user
    end
  end
end
