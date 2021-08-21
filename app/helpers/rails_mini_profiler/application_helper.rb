# frozen_string_literal: true

module RailsMiniProfiler
  module ApplicationHelper
    def present(model, presenter_class = nil, **kwargs)
      klass = presenter_class || "#{model.class}Presenter".constantize
      presenter = klass.new(model, self, **kwargs)
      yield(presenter) if block_given?
      presenter
    end

    def inline_svg(path, options = {})
      if defined?(Webpacker::Engine)
        path = "media/images/#{path}"
        inline_svg_pack_tag(path, options)
      else
        inline_svg_tag(path, options)
      end
    end
  end
end
