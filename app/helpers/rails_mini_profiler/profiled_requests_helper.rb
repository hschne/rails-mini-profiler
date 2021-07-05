# frozen_string_literal: true

module RailsMiniProfiler
  module ProfiledRequestsHelper
    include ApplicationHelper

    def formatted_duration(duration)
      duration = (duration.to_f / 100)
      duration < 1 ? duration : duration.round
    end
  end
end
