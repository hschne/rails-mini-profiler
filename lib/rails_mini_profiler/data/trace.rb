# frozen_string_literal: true

module RailsMiniProfiler
  class ProfiledRequest
    include ActiveModel::Model

    attr_reader :name, :start, :finish, :duration, :payload, :backtrace, :allocations
  end
end
