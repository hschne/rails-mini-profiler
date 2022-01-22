# frozen_string_literal: true

module RailsMiniProfiler
  class ApplicationController < RailsMiniProfiler.configuration.ui.base_controller
    rescue_from ActiveRecord::RecordNotFound, with: ->(error) { handle(error, 404) }

    before_action :check_rmp_user

    private

    def handle(error, status = 500)
      respond_to do |format|
        format.html { redirect_back(fallback_location: profiled_requests_path, alert: error.to_s) }
        format.json { render status: status, json: { message: error.to_s } }
      end
    end

    def check_rmp_user
      user = User.get(request.env).present?
      redirect_back(fallback_location: fallback_location) unless user
    end

    def fallback_location
      defined?(main_app.root_path) ? main_app.root_path : '/'
    end
  end
end
