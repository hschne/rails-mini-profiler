# frozen_string_literal: true

module RailsMiniProfiler
  class ApplicationController < ActionController::Base
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    before_action :check_current_user

    protected

    def present(model, presenter_class = nil, **kwargs)
      klass = presenter_class || "RailsMiniProfiler::#{model.class.to_s.demodulize}Presenter".constantize
      presenter = klass.new(model, view_context, **kwargs)
      yield(presenter) if block_given?
      presenter
    end

    private

    def not_found(error)
      redirect_back(fallback_location: profiled_requests_path, alert: error.to_s)
    end

    def check_current_user
      redirect_back(fallback_location: root_path) unless User.get(request.env).present?
    end
  end
end
