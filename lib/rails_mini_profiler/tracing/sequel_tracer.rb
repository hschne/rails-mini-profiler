# frozen_string_literal: true

module RailsMiniProfiler
  module Tracing
    class SequelTracer < Tracer
      def trace
        return NullTrace.new if ignore?

        payload = @event[:payload].slice(:name, :sql, :binds, :type_casted_binds)
        typecasted_binds = payload[:type_casted_binds]
        # Sometimes, typecasted binds are a proc. Not sure why. In those instances, we extract the typecasted
        # values from the proc by executing call.
        typecasted_binds = typecasted_binds.call if typecasted_binds.respond_to?(:call)
        payload[:binds] = transform_binds(payload[:binds], typecasted_binds)
        payload.delete(:type_casted_binds)
        payload.reject { |_k, v| v.blank? }
        @event[:payload] = payload
        super
      end

      private

      def transform_binds(binds, type_casted_binds)
        binds.each_with_object([]).with_index do |(binding, object), i|
          name = binding.name
          value = type_casted_binds[i]
          object << { name: name, value: value }
        end
      end

      def ignore?
        payload = @event[:payload]
        !SqlTracker.new(name: payload[:name], query: payload[:sql]).track?
      end
    end
  end
end
