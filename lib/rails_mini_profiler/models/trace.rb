# frozen_string_literal: true

module RailsMiniProfiler
  module Models
    class Trace < BaseModel
      class << self
        def from_model(attributes)
          attributes.delete('rmp_profiled_request_id')
          case attributes['name']
          when 'sql.active_record'
            QueryTrace.new(**attributes)
          when 'process_action.action_controller'
            ControllerTrace.new(**attributes)
          else
            new(**attributes)
          end
        end
      end

      attr_accessor :id, :name, :start, :finish, :duration, :payload, :backtrace, :allocations, :created_at, :updated_at
    end
  end
end
