# frozen_string_literal: true

module RailsMiniProfiler
  module Tracers
    # This serves as a central store for tracers. Based on the configuration, indidual tracers are registered and are
    # then available to subscribe to events or render traced events.
    #
    # @api private
    class Registry
      class << self
        def setup!(config)
          new(config)
        end
      end

      def initialize(config)
        @config = config
        @config.tracers.each { |tracer| add(tracer) }
      end

      # Tracers that are available in the application, indexed by events they subscribe to.
      #
      # @return [Hash] a hash where keys are event names and values are the corresponding tracers
      def tracers
        @tracers ||=
          tracer_map
            .values
            .each_with_object({}) do |tracer, obj|
            subscriptions = wrap(tracer.subscribes_to)
            subscriptions.each { |subscription| obj[subscription] = tracer }
          end
      end

      # Presenters that are available in the application, indexed by events they should present.
      #
      # @return [Hash] a hash where keys are event names and values are the corresponding presenters
      def presenters
        @presenters ||=
          tracer_map
            .values
            .each_with_object({}) do |tracer, obj|
            presenters = tracer.presents
            if presenters.is_a?(Hash)
              obj.merge!(presenters)
            else
              obj[tracer.subscribes_to] = presenters
            end
          end
      end

      private

      def tracer_map
        @tracer_map ||= {}
      end

      def add(tracer)
        tracer = tracer.to_sym
        tracer = "#{tracer.to_s.camelize}Tracer"
        constant = "RailsMiniProfiler::Tracers::#{tracer}".safe_constantize

        tracer_map[tracer] = constant if constant
      end

      def wrap(object)
        if object.nil?
          []
        elsif object.respond_to?(:to_ary)
          object.to_ary || [object]
        else
          [object]
        end
      end
    end
  end
end
