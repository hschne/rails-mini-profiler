# frozen_string_literal: true

require 'forwardable'

require 'rails_mini_profiler/version'
require 'rails_mini_profiler/storage/memory'
require 'rails_mini_profiler/configuration'
require 'rails_mini_profiler/context'
require 'rails_mini_profiler/request'
require 'rails_mini_profiler/response'
require 'rails_mini_profiler/request_context'
require 'rails_mini_profiler/guard'
require 'rails_mini_profiler/middleware'

require 'rails_mini_profiler/engine'

module RailsMiniProfiler
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def context
      @context ||= Context.instance(configuration)
    end
  end
end
