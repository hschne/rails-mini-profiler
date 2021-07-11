# frozen_string_literal: true

module RailsMiniProfiler
  class InstantiationTrace < Trace
    store :payload, accessors: %i[record_count class_name]

    class << self
      def find_sti_class(_)
        super(name)
      end

      def sti_name
        'instantiation.active_record'
      end
    end
  end
end
