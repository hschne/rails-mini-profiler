# frozen_string_literal: true

module RailsMiniProfiler
  class RenderPartialTracePresenter < TracePresenter
    def label
      root = Rails.root.to_s.split('/').to_set
      identifier = model.identifier.split('/').to_set
      (root ^ identifier).drop(2).join('/').reverse.truncate(30).reverse
    end
  end
end
