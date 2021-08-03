# frozen_string_literal: true

require 'forwardable'
require 'inline_svg'

require 'rails_mini_profiler/version'
require 'rails_mini_profiler/engine'

require 'rails_mini_profiler/user'
require 'rails_mini_profiler/request_context'

require 'rails_mini_profiler/models/base_model'
require 'rails_mini_profiler/models/trace'

require 'rails_mini_profiler/logger'
require 'rails_mini_profiler/configuration'
require 'rails_mini_profiler/storage'
require 'rails_mini_profiler/request_wrapper'
require 'rails_mini_profiler/response_wrapper'
require 'rails_mini_profiler/guard'
require 'rails_mini_profiler/flamegraph_guard'
require 'rails_mini_profiler/redirect'
require 'rails_mini_profiler/badge'
require 'rails_mini_profiler/tracers'
require 'rails_mini_profiler/middleware'

# Main namespace for Rails Mini Profiler
module RailsMiniProfiler
  class << self
    # Create a new configuration object
    #
    # @return [Configuration] a new configuration
    def configuration
      @configuration ||= Configuration.new
    end

    # Configure Rails Mini Profiler
    #
    # You may use this to configure where and how Rails Mini Profiler stores profiling and storage information.
    #
    # @see https://github.com/hschne/rails-mini-profiler#configuration
    #
    # @yieldreturn [Configuration] a new configuration
    def configure
      yield(configuration)
    end

    # Access storage configuration.
    #
    #
    # @return [Storage] a new storage configuration
    def storage_configuration
      configuration.storage.configuration
    end

    # Access the current logger
    #
    # @return [Logger] the logger instance
    def logger
      @logger ||= configuration.logger
    end

    # Authorize the current user for this request
    #
    # @param current_user [Object] the current user
    #
    # @see User#current_user
    def authorize!(current_user)
      RailsMiniProfiler::User.current_user = current_user
    end

    # Set the current user for this request
    #
    # @param current_user [Object] the current user
    #
    # @see User#current_user
    def current_user=(current_user)
      RailsMiniProfiler::User.current_user = current_user
    end
  end
end
