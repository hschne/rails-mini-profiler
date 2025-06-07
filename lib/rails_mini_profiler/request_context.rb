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
  #   @return [ResponseWrapper] the response as rendered by the application
  #   # @!attribute profiled_request
  #   @return [ProfiledRequest] the profiling data as gathered during profiling
  # @!attribute traces
  #   @return [Array<Models::Trace>] trace wrappers gathered during profiling
  # @!attribute flamegraph
  #   @return [Flamegraph] a Flamegraph, if recorded
  class RequestContext
    attr_reader :request

    attr_accessor :response, :traces, :flamegraph, :profiled_request

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

    # Save profiling data in the database.
    #
    # This will store the profiled request, as well as any attached traces and Flamgraph.
    def save_results!
      ActiveRecord::Base.transaction do
        profiled_request = build_profiled_request
        profiled_request.flamegraph = RailsMiniProfiler::Flamegraph.new(data: flamegraph) if flamegraph.present?
        profiled_request.save
        insert_traces(profiled_request) unless traces.empty?
        @profiled_request = profiled_request
      end
      @saved = true
    end

    # Check if profiling results have been saved
    #
    # @return [Boolean] true if profiling results have been saved
    def saved?
      @saved
    end

    private

    def build_profiled_request
      new_profiled_request = ProfiledRequest.new
      new_profiled_request.user_id = User.current_user
      new_profiled_request.request = @request
      new_profiled_request.response = @response
      total_time = traces.find { |trace| trace.name == 'rails_mini_profiler.total_time' }
      new_profiled_request.total_time = total_time
      new_profiled_request
    end

    # We insert multiple at once for performance reasons.
    def insert_traces(profiled_request)
      return if traces.empty?

      timestamp = Time.zone.now
      inserts = traces.reverse.map do |trace|
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
