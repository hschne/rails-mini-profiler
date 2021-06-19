# frozen_string_literal: true

require_dependency 'rails_mini_profiler/application_controller'

module RailsMiniProfiler
  class ProfiledRequestsController < ApplicationController
    before_action :set_profiled_request, only: %i[show destroy]

    def index
      @profiled_requests = repository.find_by
    end

    def show; end

    def destroy
      repository.destroy(@profiled_request.id)
      redirect_to profiled_requests_url, notice: 'Profiled request was successfully destroyed.'
    end

    private

    def set_profiled_request
      @profiled_request = repository.find(params[:id])
    end

    def configuration
      @configuration ||= RailsMiniProfiler.configuration
    end

    def repository
      @repository ||= ProfiledRequestRepository.get(rmp_user)
    end
  end
end
