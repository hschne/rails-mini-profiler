# frozen_string_literal: true

require_dependency 'rails_mini_profiler/application_controller'

module RailsMiniProfiler
  class ProfiledRequestsController < ApplicationController
    before_action :set_profiled_request, only: %i[show destroy]

    def index
      @profiled_requests = ProfiledRequest.where(user_id: user_id).order(id: :desc)
      search = ProfiledRequestSearch.new(scope: @profiled_requests, **index_params)
      @pagy, @profiled_requests = pagy(search.results, items: configuration.ui.page_size)
      @profiled_requests = @profiled_requests.map { |request| present(request) }
    end

    def show
      @traces = @profiled_request.traces
      @traces = @traces.where("#{payload_column} LIKE ?", "%#{params[:search]}%") if params[:search]
      @traces = @traces
                  .order(:start)
                  .map { |trace| present(trace, profiled_request: @profiled_request) }
      @profiled_request = present(@profiled_request)
    end

    def destroy
      ProfiledRequest.where(user_id: user_id).destroy(@profiled_request.id)
      redirect_to profiled_requests_url, notice: 'Profiled request was successfully destroyed.'
    end

    def destroy_all
      ProfiledRequest.transaction do
        requests_table_name = RailsMiniProfiler.storage_configuration.profiled_requests_table.to_sym
        profiled_requests = ProfiledRequest.where(requests_table_name => { user_id: user_id })
        profiled_requests = ProfiledRequestSearch.new(scope: profiled_requests, **index_params).results
        Flamegraph.joins(:profiled_request).merge(profiled_requests).delete_all
        Trace.joins(:profiled_request).where(requests_table_name => { user_id: user_id }).delete_all
        profiled_requests.delete_all
      end
      redirect_to profiled_requests_url, notice: 'Profiled Requests cleared'
    end

    private

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
