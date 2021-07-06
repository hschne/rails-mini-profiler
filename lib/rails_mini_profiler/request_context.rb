# frozen_string_literal: true

module RailsMiniProfiler
  class RequestContext
    attr_reader :request, :profiler_context

    attr_accessor :response, :profiled_request, :traces, :flamegraph

    def initialize(profiler_context, request)
      @profiler_context = profiler_context
      @request = request
      @env = request.env
      @saved = false
      @complete = false
    end

    def user_id
      @user_id ||= User.current_user
    end

    def authorized?
      @authorized ||= User.get(@env).present?
    end

    def complete_profiling!
      profiled_request.user_id = user_id
      profiled_request.request = @request
      profiled_request.response = @response
      total_time = traces.find { |trace| trace.name == 'rails_mini_profiler.total_time' }
      profiled_request.total_time = total_time
      @complete = true
    end

    def save_results!
      ActiveRecord::Base.transaction do
        profiled_request.flamegraph = Flamegraph.new(data: flamegraph) if flamegraph.present?
        profiled_request.save
        insert_traces unless traces.empty?
      end
      @saved = true
    end

    def complete?
      @complete
    end

    def saved?
      @saved
    end

    private

    def insert_traces
      return if traces.empty?

      timestamp = Time.zone.now
      inserts = traces.map do |trace|
        { rmp_profiled_request_id: profiled_request.id, **trace.to_h, created_at: timestamp, updated_at: timestamp }
      end
      RailsMiniProfiler::Trace.insert_all(inserts)
    end
  end
end
