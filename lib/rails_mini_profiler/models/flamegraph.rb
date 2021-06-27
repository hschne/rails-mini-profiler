# frozen_string_literal: true

module RailsMiniProfiler
  module Models
    class Flamegraph < BaseModel
      attr_accessor :data
    end

    def initialize(flamegraph)
      data = flamegraph.to_json || {}
      super(data: data)
    end
  end
end
