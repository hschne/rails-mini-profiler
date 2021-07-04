# frozen_string_literal: true

module RailsMiniProfiler
  class RmpTrace < Trace
    class << self
      def find_sti_class(_)
        super(name)
      end

      def sti_name
        'rails_mini_profiler.total_time'
      end
    end
  end
end
