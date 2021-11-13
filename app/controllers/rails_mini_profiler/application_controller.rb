# frozen_string_literal: true

module RailsMiniProfiler
  class ApplicationController < ActionController::Base
    rescue_from ActiveRecord::RecordNotFound, with: ->(error) { handle(error, 404) }

    before_action :check_current_user

    protected

    def present(model, presenter_class = nil, **kwargs)
      klass = presenter_class || "RailsMiniProfiler::#{model.class.to_s.demodulize}Presenter".constantize
      presenter = klass.new(model, view_context, **kwargs)
      yield(presenter) if block_given?
      presenter
    end

    private

    def handle(error, status = 500)
      respond_to do |format|
        format.html { redirect_back(fallback_location: profiled_requests_path, alert: error.to_s) }
        format.json { render status: status, json: { message: error.to_s } }
      end
    end

    def check_current_user
      redirect_back(fallback_location: fallback_location) unless User.get(request.env).present?
    end

    def fallback_location
      defined?(main_app.root_path) ? main_app.root_path : '/'
    end
  end
end
