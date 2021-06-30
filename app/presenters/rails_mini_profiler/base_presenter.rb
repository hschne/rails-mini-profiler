# frozen_string_literal: true

class BasePresenter < SimpleDelegator
  def initialize(model, view, **_kwargs)
    @h = view
    super(model)
  end

  attr_reader :h

  alias model __getobj__

  # To avoid having to address the view context explicitly we try to delegate to it
  def method_missing(method, *args, &block)
    h.public_send(method, *args, &block)
  rescue NoMethodError
    super
  end

  def respond_to_missing?(method_name, *args)
    h.respond_to?(method_name, *args) || super
  end
end
