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

    def icon(name, **kwargs)
      root = RailsMiniProfiler::Engine.root
      icon_path = File.read(root.join('app', 'assets', 'images', "#{name}.svg"))

      Nokogiri::HTML::DocumentFragment.parse(icon_path)
        .at_css('svg')
        .tap { _1['class'] = kwargs[:class] }
        .to_html
        .html_safe
    end
  end
end
