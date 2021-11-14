# frozen_string_literal: true

module RailsMiniProfiler
  class TracePresenter < BasePresenter
    def initialize(trace, view, context: {})
      super(trace, view)
      @start = context[:start]
      @finish = context[:finish]
      @total_duration = context[:total_duration]
      @total_allocations = context[:total_allocations]
    end

    def label
      ''
    end

    def description
      label
    end

    def content
      nil
    end

    def backtrace
      return if model.backtrace.empty?

      model.backtrace.first
    end

    def type
      # Turn this class name into a dasherized version for use in assigning CSS classes. E.g. 'RmpTracePresenter'
      # becomes 'rmp-trace'
      self.class.name.demodulize.delete_suffix('Presenter')
        .underscore
        .dasherize
    end

    def duration
      formatted_duration(model.duration)
    end

    def duration_percent
      (model.duration.to_f / @total_duration * 100).round
    end

    def allocations
      formatted_allocations(model.allocations)
    end

    def allocations_percent
      (model.allocations.to_f / @total_allocations * 100).round
    end

    def from_start
      (model.start - @start).to_f / 100
    end

    def from_start_percent
      ((model.start - @start).to_f / (@finish - @start)).to_f * 100
    end
  end
end
