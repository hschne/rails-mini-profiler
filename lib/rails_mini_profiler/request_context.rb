# frozen_string_literal: true

module RailsMiniProfiler
  class RequestContext
    attr_reader :request, :profiler_context

    def initialize(profiler_context, request)
      @profiler_context = profiler_context
      @request = request
    end

    def user
      @user ||= @profiler_context.configuration.user_provider.call(@env)
    end
  end
end
