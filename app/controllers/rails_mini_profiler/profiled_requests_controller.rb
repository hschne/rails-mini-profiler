require_dependency "rails_mini_profiler/application_controller"

module RailsMiniProfiler
  class ProfiledRequestsController < ApplicationController
    before_action :set_profiled_request, only: [:show, :destroy]

    def index
      @profiled_requests = storage.all

      render(json: @profiled_requests)
    end

    def show
      render(json: @profiled_request.to_h)
    end

    def destroy
      @profiled_request.destroy
      redirect_to profiled_requests_url, notice: 'Profiled request was successfully destroyed.'
    end

    private

    def set_profiled_request
      @profiled_request = storage.find(params[:id])
    end

    def configuration
      @configuration ||= RailsMiniProfiler.configuration
    end

    def storage
      @profiled_requests ||= Context.instance(configuration).storage_instance
    end
  end
end
