# frozen_string_literal: true

module RailsMiniProfiler
  module Models
    class Trace < BaseModel
      attr_accessor :id, :name, :start, :finish, :duration, :payload, :backtrace, :allocations, :created_at, :updated_at
    end
  end
end
