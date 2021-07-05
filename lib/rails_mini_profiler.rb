# frozen_string_literal: true

require 'forwardable'
require 'inline_svg'

require 'rails_mini_profiler/version'
require 'rails_mini_profiler/engine'

require 'rails_mini_profiler/errors'

require 'rails_mini_profiler/user'
require 'rails_mini_profiler/request_context'

require 'rails_mini_profiler/models/base_model'
require 'rails_mini_profiler/models/trace'


require 'rails_mini_profiler/configuration'
require 'rails_mini_profiler/storage'
require 'rails_mini_profiler/profiler_context'
require 'rails_mini_profiler/request_wrapper'
require 'rails_mini_profiler/response_wrapper'
require 'rails_mini_profiler/guard'
require 'rails_mini_profiler/flamegraph_guard'
require 'rails_mini_profiler/redirect'
require 'rails_mini_profiler/badge'
require 'rails_mini_profiler/tracers'
require 'rails_mini_profiler/middleware'

module RailsMiniProfiler
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def storage_configuration
      configuration.storage.configuration
    end

    def context
      @context ||= ProfilerContext.instance(configuration)
    end

    def authorize!(current_user)
      RailsMiniProfiler::User.current_user = current_user
    end

    def current_user=(current_user)
      RailsMiniProfiler::User.current_user = current_user
    end
  end
end
