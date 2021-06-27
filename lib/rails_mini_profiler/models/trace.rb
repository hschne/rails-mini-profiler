# frozen_string_literal: true

module RailsMiniProfiler
  module Models
    class Trace < BaseModel
      attr_accessor :name, :start, :finish, :duration, :payload, :backtrace, :allocations
    end
  end
end
