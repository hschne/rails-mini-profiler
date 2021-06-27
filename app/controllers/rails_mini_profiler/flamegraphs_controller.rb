# frozen_string_literal: true

require_dependency 'rails_mini_profiler/application_controller'

module RailsMiniProfiler
  class FlamegraphsController < ApplicationController
    layout 'rails_mini_profiler/flamegraph'

    before_action :set_flamegraph, only: %i[show]

    def show; end

    private

    def set_flamegraph
      @flamegraph_guard = JSON.generate(repository.find(params[:id]).flamegraph)
    end

    def configuration
      @configuration ||= RailsMiniProfiler.configuration
    end

    def repository
      @repository ||= Repositories::ProfiledRequestRepository.get(rmp_user)
    end
  end
end
