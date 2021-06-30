# frozen_string_literal: true

module RailsMiniProfiler
  module ApplicationHelper
    def present(model, presenter_class = nil, **kwargs)
      klass = presenter_class || "#{model.class}Presenter".constantize
      presenter = klass.new(model, self, **kwargs)
      yield(presenter) if block_given?
      presenter
    end
  end
end
