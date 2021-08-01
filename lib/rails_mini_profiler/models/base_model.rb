# frozen_string_literal: true

module RailsMiniProfiler
  # Thin wrappers around request/response classes
  #
  # @api private
  module Models
    # A pseudo model to be used to wrap profiling information. We can't use regular models, as their connecting
    # to the database results in problems when profiling.
    class BaseModel
      include ActiveModel::Model

      def initialize(*_args, **attributes)
        super(attributes)
      end

      def to_h
        instance_variables
          .each_with_object({}) { |var, hash| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      end
    end
  end
end
