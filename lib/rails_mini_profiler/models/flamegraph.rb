# frozen_string_literal: true

module RailsMiniProfiler
  module Models
    class Flamegraph
      include ActiveModel::Model

      attr_reader :data
    end
  end
end
