# frozen_string_literal: true

module RailsMiniProfiler
  class RenderPartialTrace < Trace
    store :payload, accessors: %i[identifier]

    class << self
      def find_sti_class(_)
        super(name)
      end

      def sti_name
        'render_partial.action_view'
      end
    end
  end
end
