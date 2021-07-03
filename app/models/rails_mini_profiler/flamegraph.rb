# frozen_string_literal: true

# == Schema Information
#
# Table name: rmp_flamegraphs
#
#  id                      :integer          not null, primary key
#  rmp_profiled_request_id :integer          not null
#  data                    :json
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
module RailsMiniProfiler
  class Flamegraph < ApplicationRecord
    self.table_name = 'rmp_flamegraphs'

    belongs_to :profiled_request, class_name: 'RailsMiniProfiler::ProfiledRequest',
                                  foreign_key: :rmp_profiled_request_id
  end
end
