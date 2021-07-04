# frozen_string_literal: true

module RailsMiniProfiler
  class RenderTemplateTracePresenter < TracePresenter
    def label
      root = Rails.root.to_s.split('/').to_set
      identifier = model.identifier.split('/').to_set
      (root ^ identifier).drop(2).join('/').reverse.truncate(30).reverse
    end

    def description
      "Render #{label}"
    end

  end
end
