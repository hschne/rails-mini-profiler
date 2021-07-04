# frozen_string_literal: true

require_dependency 'rails_mini_profiler/application_controller'

module RailsMiniProfiler
  class ProfiledRequestsController < ApplicationController
    before_action :set_profiled_request, only: %i[show destroy]

    def index
      @profiled_requests = ProfiledRequest.where(user_id: user_id).order(id: :desc)
      @profiled_requests = @profiled_requests.where('request_path LIKE %?%', path) if params[:path]
    end

    def show
      @traces = @profiled_request.traces
                  .order(:start)
                  .map { |trace| present(trace, profiled_request: @profiled_request) }
    end

    def destroy
      ProfiledRequest.where(user_id: user_id).destroy(@profiled_request.id)
      redirect_to profiled_requests_url, notice: 'Profiled request was successfully destroyed.'
    end

    def destroy_all
      ProfiledRequest.where(user_id: user_id).destroy_all
      redirect_to profiled_requests_url, notice: 'Profiled Requests cleared'
    end

    private

    def user_id
      @user_id ||= User.get(request.env)
    end

    def set_profiled_request
      @profiled_request = ProfiledRequest.where(user_id: user_id).find(params[:id])
    end

    def configuration
      @configuration ||= RailsMiniProfiler.configuration
    end
  end
end
