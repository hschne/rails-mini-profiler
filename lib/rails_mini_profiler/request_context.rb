# frozen_string_literal: true

module RailsMiniProfiler
  class RequestContext
    attr_reader :request, :profiler_context

    attr_accessor :response, :profiled_request

    def initialize(profiler_context, request)
      @profiler_context = profiler_context
      @request = request
      @env = request.env
    end

    def user_id
      @user_id ||= User.current_user
    end

    def authorized?
      @authorized ||= User.current_user.present?
    end

    def set_default_user!
      return unless Rails.env.development? || Rails.env.test?

      return if User.current_user

      user = @profiler_context.configuration.user_provider.call(@env)
      User.current_user = user
    end
  end
end
