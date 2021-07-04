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
  class ProfiledRequest < ApplicationRecord
    # TODO: Make customizable via configuration
    self.table_name = 'rmp_profiled_requests'

    has_one :flamegraph,
            class_name: 'RailsMiniProfiler::Flamegraph',
            foreign_key: :rmp_profiled_request_id,
            dependent: :destroy

    has_many :traces,
             class_name: 'RailsMiniProfiler::Trace',
             foreign_key: :rmp_profiled_request_id,
             dependent: :destroy

    # TODO: Add a bunch of validations

    def request=(request)
      @request_body = request.body || ''
      @request_method = request.method || 'GET'
      @request_path = request.path || ''
      @request_headers = request.headers || []
    end

    def response=(response)
      @response_body = ''
      @response_headers = response.headers || ''
      @response_status = response.status || 200
    end

    def total_time=(total_time)
      @start = total_time.start
      @finish = total_time.finish
      @duration = total_time.duration
      @allocations = total_time.allocations
    end
  end
end
