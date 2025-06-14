# frozen_string_literal: true

require_dependency 'rails_mini_profiler/application_controller'

module RailsMiniProfiler
  class ProfiledRequestsController < ApplicationController
    before_action :set_profiled_request, only: %i[show destroy]

    def index
      @profiled_requests = ProfiledRequest.where(user_id: user_id).order(id: :desc)
      search = ProfiledRequestSearch.new(index_params, scope: @profiled_requests)

      @pagination, @profiled_requests = pagination(search)
      @profiled_requests = @profiled_requests.map { |request| present(request) }
    end

    def show
      search = TraceSearch.new(show_params, scope: @profiled_request.traces)
      context = {
        start: @profiled_request.start,
        finish: @profiled_request.finish,
        total_duration: @profiled_request.duration,
        total_allocations: @profiled_request.allocations
      }
      @traces = search.results
                  .order(:start)
                  .map { |trace| present(trace, context: context) }
      @profiled_request = present(@profiled_request)
    end

    def destroy
      ProfiledRequest.where(user_id: user_id).destroy(@profiled_request.id)
      redirect_to profiled_requests_url, notice: 'Profiled request was successfully destroyed.'
    end

    def destroy_all
      ProfiledRequest.transaction do
        profiled_requests = ProfiledRequest.where(user_id: user_id)
        profiled_requests = ProfiledRequestSearch.new(index_params, scope: profiled_requests).results
        Flamegraph.joins(:profiled_request).merge(profiled_requests).delete_all
        Trace.joins(:profiled_request).merge(profiled_requests).delete_all
        profiled_requests.delete_all
      end
      redirect_to profiled_requests_url, notice: 'Profiled requests cleared', status: :see_other
    end

    private

    def show_params
      params.permit(:id, :payload, :duration, :allocations, name: [])
    end

    def index_params
      params.permit(:path, :duration, id: [], method: [], media_type: [], status: [])
    end

    def user_id
      @user_id ||= User.get(request.env)
    end

    def set_profiled_request
      @profiled_request = ProfiledRequest.where(user_id: user_id).find(params[:id])
    end

    def configuration
      @configuration ||= RailsMiniProfiler.configuration
    end

    def registry
      @registry ||= RailsMiniProfiler::Tracers::Registry.new(configuration)
    end

    def present(model, presenter_class = nil, **)
      klass = presenter_class || presenter_class(model)
      klass.new(model, view_context, **)
    end

    def presenter_class(model)
      return ProfiledRequestPresenter if model.is_a?(ProfiledRequest)

      presenters = registry.presenters
      presenters[model.name] || TracePresenter
    end

    def pagination(search)
      page = (params[:page] || 1).to_i
      per_page = configuration.ui.page_size
      total_count = search.results.count

      pagination = Pagination.new(
        page: page,
        per_page: per_page,
        total_count: total_count
      )

      profiled_requests = search.results.limit(per_page).offset(pagination.offset)
      [pagination, profiled_requests]
    end

    def payload_column
      if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
        # Cast json field to text to have access to the LIKE operator
        'payload::text'
      else
        'payload'
      end
    end
  end
end
