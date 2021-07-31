# frozen_string_literal: true

# == Schema Information
#
# Table name: rmp_traces
#
#  id                      :integer          not null, primary key
#  rmp_profiled_request_id :bigint           not null
#  name                    :string
#  start                   :bigint
#  finish                  :bigint
#  duration                :integer
#  allocations             :bigint
#  payload                 :json
#  backtrace               :json
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_rmp_traces_on_rmp_profiled_request_id  (rmp_profiled_request_id)
#
module RailsMiniProfiler
  class Trace < RailsMiniProfiler::ApplicationRecord
    self.table_name = RailsMiniProfiler.storage_configuration.traces_table
    self.inheritance_column = :name

    belongs_to :profiled_request,
               class_name: 'RailsMiniProfiler::ProfiledRequest',
               foreign_key: :rmp_profiled_request_id

    class << self
      def find_sti_class(name)
        subclasses = {
          'process_action.action_controller' => RailsMiniProfiler::ControllerTrace,
          'sql.active_record' => RailsMiniProfiler::SequelTrace,
          'instantiation.active_record' => RailsMiniProfiler::InstantiationTrace,
          'rails_mini_profiler.total_time' => RailsMiniProfiler::RmpTrace,
          'render_template.action_view' => RailsMiniProfiler::RenderTemplateTrace,
          'render_partial.action_view' => RailsMiniProfiler::RenderPartialTrace
        }
        subclasses[name] || self
      end
    end
  end
end
