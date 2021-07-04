# frozen_string_literal: true

# == Schema Information
#
# Table name: rmp_traces
#
#  id                      :integer          not null, primary key
#  rmp_profiled_request_id :integer          not null
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
  class Trace < ApplicationRecord
    self.table_name = 'rmp_traces'
    self.inheritance_column = :name

    SUBCLASSES = {
      RailsMiniProfiler::ControllerTrace => 'process_action.action_controller',
      RailsMiniProfiler::SequelTrace => 'sql.active_record',
      RailsMiniProfiler::RmpTrace => 'rails_mini_profiler.total_time',
      RailsMiniProfiler::RenderTemplateTrace => 'render_template.action_view',
      RailsMiniProfiler::RenderPartialTrace => 'render_partial.action_view'
    }.freeze

    belongs_to :profiled_request,
               class_name: 'RailsMiniProfiler::ProfiledRequest',
               foreign_key: :rmp_profiled_request_id

    class << self
      def find_sti_class(name)
        SUBCLASSES.invert[name] || self
      end
    end
  end
end
