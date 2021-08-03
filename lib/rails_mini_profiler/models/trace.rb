# frozen_string_literal: true

module RailsMiniProfiler
  module Models
    # A simplified representation of a trace.
    #
    # Is transformed into [RailsMiniProfiler::Trace] when recording has finished.
    #
    # @see https://guides.rubyonrails.org/active_support_instrumentation.html
    #
    # @!attribute id
    #   @return [Integer] the trace ID
    # @!attribute name
    #   @return [Integer] the trace type.
    # @!attribute start
    #   @return [Integer] the trace start as microsecond timestamp
    # @!attribute finish
    #   @return [Integer] the trace finish as microsecond timestamp
    # @!attribute duration
    #   @return [Integer] the trace duration
    # @!attribute payload
    #   @return [Hash] a subset of trace data
    # @!attribute backtrace
    #   @return [String] the line where this trace was recorded
    # @!attribute allocations
    #   @return [Integer] the number of alloactions
    # @!attribute created_at
    #   @return [DateTime] the creation date
    # @!attribute updated_at
    #   @return [DateTime] the last updated date
    #
    # @api private
    class Trace < BaseModel
      attr_accessor :id, :name, :start, :finish, :duration, :payload, :backtrace, :allocations, :created_at, :updated_at
    end
  end
end
