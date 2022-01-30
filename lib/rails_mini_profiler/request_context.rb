# frozen_string_literal: true

module RailsMiniProfiler
  # A working context for the duration of a request, as it runs through Rails Mini Profiler's middleware
  #
  # Contains all information that is being gathered while profiling is active. At the end of the request processing,
  # the request context is converted into a models which are then stored in the host apps database.
  #
  # @!attribute [r] request
  #   @return [RequestWrapper] the request as sent to the application
  # @!attribute response
  #   @return [Rack::Response] the response as rendered by the application
  # @!attribute profiled_request
  #   @return [ProfiledRequest] the profiling data as gathered during profiling
  # @!attribute traces
  #   @return [Array<Models::Trace>] trace wrappers gathered during profiling
  # @!attribute flamegraph
  #   @return [Flamegraph] a Flamegraph, if recorded
  class RequestContext
    attr_reader :request

    attr_accessor :response, :profiled_request, :traces, :flamegraph

    # Create a new request context
    #
    # @param request [RequestWrapper] the request as sent to the application
    def initialize(request)
      @request = request
      @env = request.env
      @saved = false
      @complete = false
    end

    # If a user is currently authorized
    #
    # @return [Boolean] true if the user is authorized
    def authorized?
      @authorized ||= User.get(@env).present?
    end

    # Completes profiling, setting all data and preparing for saving it.
    def complete_profiling!
      profiled_request.user_id = User.current_user
      profiled_request.request = @request
      profiled_request.response = @response
      total_time = traces.find { |trace| trace.name == 'rails_mini_profiler.total_time' }
      profiled_request.total_time = total_time
      @complete = true
    end

    # Save profiling data in the database.
    #
    # This will store the profiled request, as well as any attached traces and Flamgraph.
    def save_results!
      ActiveRecord::Base.transaction do
        profiled_request.flamegraph = RailsMiniProfiler::Flamegraph.new(data: flamegraph) if flamegraph.present?
        profiled_request.save
        insert_traces unless traces.empty?
      end
      @saved = true
    end

    # Check if the wrapped request has been profiled
    #
    # @return [Boolean] true if the wrapped request has been profiled
    def complete?
      @complete
    end

    # Check if profiling results have been saved
    #
    # @return [Boolean] true if profiling results have been saved
    def saved?
      @saved
    end

    private

    def insert_traces
      return if traces.empty?

      timestamp = Time.zone.now
      inserts = traces.map do |trace|
        {
          rmp_profiled_request_id: profiled_request.id,
          created_at: timestamp,
          updated_at: timestamp,
          **trace.to_h.symbolize_keys # Symbolize keys needed for Ruby 2.6
        }
      end
      RailsMiniProfiler::Trace.insert_all(inserts)
    end
  end
end
