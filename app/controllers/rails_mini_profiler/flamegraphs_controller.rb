# frozen_string_literal: true

require_dependency 'rails_mini_profiler/application_controller'

module RailsMiniProfiler
  class FlamegraphsController < ApplicationController
    layout 'rails_mini_profiler/flamegraph'

    before_action :set_flamegraph, only: %i[show]

    def show
      respond_to do |format|
        format.html
        format.json { render json: @flamegraph }
      end
    end

    private

    def set_flamegraph
      @flamegraph = Flamegraph.find_by!(rmp_profiled_request_id: params[:id]).json_data
    end

    def configuration
      @configuration ||= RailsMiniProfiler.configuration
    end
  end
end
