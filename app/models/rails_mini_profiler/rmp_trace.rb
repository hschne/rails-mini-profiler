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
# Indexes
#
#  index_rmp_traces_on_rmp_profiled_request_id  (rmp_profiled_request_id)
#
module RailsMiniProfiler
  class RmpTrace < Trace
    class << self
      def find_sti_class(_)
        super(name)
      end

      def sti_name
        'rails_mini_profiler.total_time'
      end
    end
  end
end
