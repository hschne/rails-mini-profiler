# frozen_string_literal: true

module RailsMiniProfiler
  module Models
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
