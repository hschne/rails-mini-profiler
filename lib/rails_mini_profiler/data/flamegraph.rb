# frozen_string_literal: true

module RailsMiniProfiler
  class Flamegraph
    include ActiveModel::Model

    attr_reader :data
  end
end
