# frozen_string_literal: true

module RailsMiniProfiler
  module ApplicationHelper
    include Pagy::Frontend

    def present(model, presenter_class = nil, **)
      klass = presenter_class || "#{model.class}Presenter".constantize
      presenter = klass.new(model, self, **)
      yield(presenter) if block_given?
      presenter
    end

    def inline_svg(path, options = {})
      inline_svg_tag(path, options)
    end
  end
end
