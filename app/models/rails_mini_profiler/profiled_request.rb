# frozen_string_literal: true

# == Schema Information
#
# Table name: rmp_profiled_requests
#
#  id               :integer          not null, primary key
#  user_id          :string
#  start            :datetime
#  finish           :datetime
#  duration         :integer
#  allocations      :integer
#  response_status  :integer
#  response_body    :json
#  response_headers :json
#  request_path     :string
#  request_headers  :json
#  request_body     :json
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
module RailsMiniProfiler
  class ProfiledRequest < ApplicationRecord
    self.table_name = 'rmp_profiled_requests'

    has_one :flamegraph,
            class_name: 'RailsMiniProfiler::Flamegraph',
            foreign_key: :rmp_profiled_request_id,
            dependent: :destroy

    has_many :traces,
             class_name: 'RailsMiniProfiler::Trace',
             foreign_key: :rmp_profiled_request_id,
             dependent: :destroy
  end
end
