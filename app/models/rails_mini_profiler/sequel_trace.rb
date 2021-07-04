# frozen_string_literal: true

module RailsMiniProfiler
  class SequelTrace < Trace
    store :payload, accessors: %i[name sql binds]

    class << self
      def find_sti_class(_)
        super(name)
      end

      def sti_name
        'sql.active_record'
      end
    end
  end
end
