# frozen_string_literal: true

module RailsMiniProfiler
  module Data
    class ProfiledRequest
      include ActiveModel::Model
      include ActiveModel::Serialization

      attr_reader :id,
                  :user,
                  :start,
                  :finish,
                  :duration,
                  :allocations,
                  :response_status,
                  :response_body,
                  :response_headers,
                  :request_headers,
                  :request_body,
                  :flamegraph,
                  :traces
    end
  end
end
