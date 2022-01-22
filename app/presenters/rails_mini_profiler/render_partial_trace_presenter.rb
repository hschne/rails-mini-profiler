# frozen_string_literal: true

module RailsMiniProfiler
  class RenderPartialTracePresenter < TracePresenter
    def identifier
      payload['identifier']
    end

    def label
      root = Rails.root.to_s.split('/').to_set
      id = identifier.split('/').to_set
      (root ^ id).drop(2).join('/').reverse.truncate(30).reverse
    end
  end
end
