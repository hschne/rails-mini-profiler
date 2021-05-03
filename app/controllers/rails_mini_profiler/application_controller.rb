# frozen_string_literal: true

module RailsMiniProfiler
  class ApplicationController < ActionController::Base

    def profiler_user
      @profiler_user ||= RailsMiniProfiler.configuration.user_provider.call(request.env)
    end
  end
end
