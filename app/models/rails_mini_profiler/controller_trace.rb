# frozen_string_literal: true

module RailsMiniProfiler
  class ControllerTrace < Trace
    store :payload, accessors: %i[view_runtime db_runtime]

    class << self
      def find_sti_class(_)
        super(name)
      end

      def sti_name
        'process_action.action_controller'
      end
    end
  end
end
