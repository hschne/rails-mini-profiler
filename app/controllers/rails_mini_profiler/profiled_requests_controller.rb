# frozen_string_literal: true

require_dependency 'rails_mini_profiler/application_controller'

module RailsMiniProfiler
  class ProfiledRequestsController < ApplicationController
    before_action :set_profiled_request, only: %i[show destroy]

    def index
      @profiled_requests = params[:path] ? repository.find_by(path: params[:path]) : repository.all
    end

    def show; end

    def destroy
      repository.destroy(@profiled_request.id)
      redirect_to profiled_requests_url, notice: 'Profiled request was successfully destroyed.'
    end

    def destroy_all
      repository.destroy_all
      redirect_to profiled_requests_url, notice: 'Profiled Requests cleared'
    end

    private

    def set_profiled_request
      @profiled_request = repository.find(params[:id])
    end

    def configuration
      @configuration ||= RailsMiniProfiler.configuration
    end

    def repository
      @repository ||= Repositories::ProfiledRequestRepository.get(rmp_user)
    end
  end
end
