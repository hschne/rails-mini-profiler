# frozen_string_literal: true

module RailsMiniProfiler
  class BasePresenter < SimpleDelegator
    def initialize(model, view, **_kwargs)
      @h = view
      super(model)
    end

    attr_reader :h

    alias model __getobj__

    # To avoid having to address the view context explicitly we try to delegate to it
    def method_missing(method, *, &)
      h.public_send(method, *, &)
    rescue NoMethodError
      super
    end

    def respond_to_missing?(method_name, *)
      h.respond_to?(method_name, *) || super
    end
  end
end
