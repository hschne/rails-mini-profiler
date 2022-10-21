# frozen_string_literal: true

# == Schema Information
#
# Table name: rmp_profiled_requests
#
#  id                   :integer          not null, primary key
#  user_id              :string
#  start                :bigint
#  finish               :bigint
#  duration             :integer
#  allocations          :bigint
#  request_path         :string
#  request_query_string :string
#  request_method       :string
#  request_headers      :json
#  request_body         :text
#  response_status      :integer
#  response_body        :text
#  response_headers     :json
#  response_media_type  :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_rmp_profiled_requests_on_created_at  (created_at)
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

    before_save :sanitize

    def request=(request)
      self.request_body = request.body
      self.request_headers = request.headers
      self.request_method = request.request_method
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

    private

    def sanitize
      self.request_body ||= ''
      self.request_body = request_body
                            .encode('UTF-8', invalid: :replace, undef: :replace)
                            .delete("\000")
    end
  end
end
