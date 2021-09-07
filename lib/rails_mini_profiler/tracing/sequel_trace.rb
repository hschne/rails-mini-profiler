module RailsMiniProfiler
  module Tracing
    class SequelTrace < Trace

      def ignore?
        !SqlTracker.new(name: payload[:name], query: payload[:sql]).track?
      end

      def transform!
        transform_payload!
      end

      private

      def transform_payload!
        payload = @payload.slice(:name, :sql, :binds, :type_casted_binds)
        typecasted_binds = payload[:type_casted_binds]
        # Sometimes, typecasted binds are a proc. Not sure why. In those instances, we extract the typecasted
        # values from the proc by executing call.
        typecasted_binds = typecasted_binds.call if typecasted_binds.respond_to?(:call)
        payload[:binds] = transform_binds(payload[:binds], typecasted_binds)
        payload.delete(:type_casted_binds)
        payload.reject { |_k, v| v.blank? }
        @payload = payload
      end

      def transform_binds(binds, type_casted_binds)
        binds.each_with_object([]).with_index do |(binding, object), i|
          name = binding.name
          value = type_casted_binds[i]
          object << { name: name, value: value }
        end
      end
    end
  end
end
