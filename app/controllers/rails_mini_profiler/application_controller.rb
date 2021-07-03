# frozen_string_literal: true

module RailsMiniProfiler
  class ApplicationController < ::ApplicationController
    rescue_from RecordNotFound, with: :not_found

    before_action :check_current_user

    private

    def not_found(error)
      redirect_back(fallback_location: profiled_requests_path, alert: error.to_s)
    end

    def check_current_user
      redirect_back(fallback_location: root_path) unless User.get(request.env).present?
    end
  end
end
