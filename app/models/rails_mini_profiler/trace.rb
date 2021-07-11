# frozen_string_literal: true

# == Schema Information
#
# Table name: rmp_traces
#
#  id                      :integer          not null, primary key
#  rmp_profiled_request_id :bigint           not null
#  name                    :string
#  start                   :integer
#  finish                  :integer
#  duration                :integer
#  allocations             :integer
#  payload                 :json
#  backtrace               :json
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
module RailsMiniProfiler
  class Trace < RailsMiniProfiler::ApplicationRecord
    self.table_name = 'rmp_traces'
    self.inheritance_column = :name


    belongs_to :profiled_request,
               class_name: 'RailsMiniProfiler::ProfiledRequest',
               foreign_key: :rmp_profiled_request_id

    class << self
      def find_sti_class(name)
        subclasses = {
          RailsMiniProfiler::ControllerTrace => 'process_action.action_controller',
          RailsMiniProfiler::SequelTrace => 'sql.active_record',
          RailsMiniProfiler::InstantiationTrace => 'instantiation.active_record',
          RailsMiniProfiler::RmpTrace => 'rails_mini_profiler.total_time',
          RailsMiniProfiler::RenderTemplateTrace => 'render_template.action_view',
          RailsMiniProfiler::RenderPartialTrace => 'render_partial.action_view'
        }
        subclasses.invert[name] || self
      end
    end
  end
end
