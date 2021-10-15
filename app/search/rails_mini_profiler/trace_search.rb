# frozen_string_literal: true

module RailsMiniProfiler
  class TraceSearch < BaseSearch
    option(:name) do |scope, value|
      scope.where(name: value)
    end

    option(:duration) do |scope, value|
      scope.where('duration > :duration', duration: value)
    end

    option(:allocations) do |scope, value|
      scope.where('allocations > :allocations', allocations: value)
    end

    option(:payload) do |scope, value|
      payload_column = DatabaseAdapter.cast_to_text(:payload)
      scope.where("#{payload_column} LIKE ?", "%#{value}%")
    end

    option(:backtrace) do |scope, value|
      backtrace_column = Adapters::DatabaseAdapter.cast_to_text(:backtrace)
      scope.where("#{backtrace_column} LIKE ?", "%#{value}%")
    end
  end
end
