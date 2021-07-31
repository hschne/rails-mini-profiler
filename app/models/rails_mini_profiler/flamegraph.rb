# frozen_string_literal: true

# == Schema Information
#
# Table name: rmp_flamegraphs
#
#  id                      :integer          not null, primary key
#  rmp_profiled_request_id :bigint           not null
#  data                    :binary
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_rmp_flamegraphs_on_rmp_profiled_request_id  (rmp_profiled_request_id)
#
module RailsMiniProfiler
  class Flamegraph < RailsMiniProfiler::ApplicationRecord
    self.table_name = RailsMiniProfiler.storage_configuration.flamegraphs_table

    belongs_to :profiled_request,
               class_name: 'RailsMiniProfiler::ProfiledRequest',
               foreign_key: :rmp_profiled_request_id

    before_save :compress

    def json_data
      @json_data = ActiveSupport::Gzip.decompress(data)
    end

    private

    def compress
      self.data = ActiveSupport::Gzip.compress(data)
    end
  end
end
