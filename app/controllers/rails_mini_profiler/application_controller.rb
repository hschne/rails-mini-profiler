# frozen_string_literal: true

module RailsMiniProfiler
  class ApplicationController < ::ApplicationController
    rescue_from RecordNotFound, with: :not_found

    unless respond_to?(:rmp_user)
      def rmp_user
        @rmp_user ||= RailsMiniProfiler.configuration.user_provider.call(request.env)
      end
    end

    private

    def not_found(error)
      redirect_back(fallback_location: profiled_requests_path, alert: error.to_s)
    end
  end
end
