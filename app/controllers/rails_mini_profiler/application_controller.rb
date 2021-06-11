# frozen_string_literal: true

module RailsMiniProfiler
  class ApplicationController < ActionController::Base
    rescue_from RecordNotFound, with: :not_found

    def profiler_user
      @profiler_user ||= RailsMiniProfiler.configuration.user_provider.call(request.env)
    end

    private

    def not_found(error)
      redirect_back(fallback_location: profiled_requests_path, alert: error.to_s)
    end
  end
end
