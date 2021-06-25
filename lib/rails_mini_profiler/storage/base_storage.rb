# frozen_string_literal: true

module RailsMiniProfiler
  module Storage
    class BaseStorage
      class << self
        def to_sym
          name.to_s.demodulize.underscore.to_sym
        end

        def configuration
          @configuration ||= new.configuration
        end
      end

      attr_accessor :max_size

      def initialize(**kwargs)
        defaults!
        kwargs.each { |key, value| instance_variable_set("@#{key}", value) }
      end

      def configuration
        self.class.configuration
      end

      def name
        self.class.name
      end

      def to_sym
        self.class.to_sym
      end

      def defaults!
        @max_size = 25
      end
    end
  end
end
