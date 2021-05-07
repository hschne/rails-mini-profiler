# frozen_string_literal: true

require_dependency 'rails_mini_profiler/application_controller'

module RailsMiniProfiler
  class FlamegraphsController < ApplicationController
    layout 'rails_mini_profiler/flamegraph'

    before_action :set_flamegraph, only: %i[show]

    def show; end

    private

    def set_flamegraph
      @flamegraph = JSON.generate(storage.find(params[:id]).flamegraph)
    end

    def configuration
      @configuration ||= RailsMiniProfiler.configuration
    end

    def storage
      @storage ||= ProfilerContext.instance(configuration).storage_instance
    end
  end
end
