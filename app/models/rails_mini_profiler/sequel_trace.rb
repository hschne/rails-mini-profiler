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
  class SequelTrace < Trace
    store :payload, accessors: %i[name sql binds]

    class << self
      def find_sti_class(_)
        super(name)
      end

      def sti_name
        'sql.active_record'
      end
    end
  end
end
