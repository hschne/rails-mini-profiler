# frozen_string_literal: true

module RailsMiniProfiler
  module ProfiledRequestsHelper
    include ApplicationHelper

    def formatted_duration(duration)
      duration = (duration.to_f / 100)
      duration < 1 ? duration : duration.round
    end

    def formatted_allocations(allocations)
      number_to_human(allocations, units: { unit: '', thousand: 'k', million: 'M', billion: 'B', trillion: 'T' })
    end
  end
end
