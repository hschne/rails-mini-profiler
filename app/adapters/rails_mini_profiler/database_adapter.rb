# frozen_string_literal: true

module RailsMiniProfiler
  class DatabaseAdapter
    class << self
      def cast_to_text(column)
        if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
          # Cast json field to text to have access to the LIKE operator
          "#{column}::text"
        else
          column
        end
      end
    end
  end
end
