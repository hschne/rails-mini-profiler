# frozen_string_literal: true

module RailsMiniProfiler
  module ApplicationHelper
    include Pagy::Frontend

    def present(model, presenter_class = nil, **kwargs)
      klass = presenter_class || "#{model.class}Presenter".constantize
      presenter = klass.new(model, self, **kwargs)
      yield(presenter) if block_given?
      presenter
    end

    def inline_svg(path, options = {})
      inline_svg_tag(path, options)
    end
  end
end
