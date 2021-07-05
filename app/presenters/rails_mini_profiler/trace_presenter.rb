# frozen_string_literal: true

module RailsMiniProfiler
  class TracePresenter < BasePresenter
    def initialize(trace, view, profiled_request:)
      super(trace, view)
      @profiled_request = profiled_request
    end

    def label
      ''
    end

    def description
      label
    end

    def payload
      nil
    end

    def backtrace
      return if model.backtrace.empty?

      model.backtrace.first
    end

    def type
      # Turn this class name into a dasherized version for use in assigning CSS classes. E.g. 'RmpTracePresenter' becomes
      # 'rmp-trace'
      self.class.name.demodulize.delete_suffix('Presenter')
        .underscore
        .dasherize
    end

    def duration
      formatted_duration(model.duration)
    end

    def duration_percent
      (model.duration.to_f / @profiled_request.duration * 100).round
    end

    def allocations_percent
      (model.allocations.to_f / @profiled_request.allocations * 100).round
    end

    def from_start
      (model.start - @profiled_request.start).to_f / 100
    end

    def from_start_percent
      ((model.start - @profiled_request.start).to_f /
        (@profiled_request.finish - @profiled_request.start)).to_f * 100
    end
  end
end
