# frozen_string_literal: true

# == Schema Information
#
# Table name: rmp_profiled_requests
#
#  id               :integer          not null, primary key
#  user_id          :string
#  start            :integer
#  finish           :integer
#  duration         :integer
#  allocations      :integer
#  request_path     :string
#  request_method   :string
#  request_headers  :json
#  request_body     :json
#  response_status  :integer
#  response_body    :json
#  response_headers :json
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
module RailsMiniProfiler
  class ProfiledRequest < RailsMiniProfiler::ApplicationRecord
    self.table_name = RailsMiniProfiler.storage_configuration.profiled_requests_table

    has_one :flamegraph,
            class_name: 'RailsMiniProfiler::Flamegraph',
            foreign_key: :rmp_profiled_request_id,
            dependent: :destroy

    has_many :traces,
             class_name: 'RailsMiniProfiler::Trace',
             foreign_key: :rmp_profiled_request_id,
             dependent: :destroy

    def request=(request)
      self.request_body = request.body
      self.request_headers = request.headers
      self.request_method = request.method
      self.request_path = request.path
      self.request_query_string = request.query_string
    end

    def response=(response)
      self.response_body = response.body
      self.response_media_type = response.media_type
      self.response_headers = response.headers
      self.response_status = response.status
    end

    def total_time=(total_time)
      self.start = total_time.start
      self.finish = total_time.finish
      self.duration = total_time.duration
      self.allocations = total_time.allocations
    end
  end
end
