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

    def trace_display_name(name)
      {
        'sql.active_record': 'ActiveRecord Query',
        'instantiation.active_record': 'ActiveRecord Instantiation',
        'render_template.action_view': 'Render View',
        'render_partial.action_view': 'Render Partial',
        'process_action.action_controller': 'Controller'
      }[name.to_sym]
    end
  end
end
