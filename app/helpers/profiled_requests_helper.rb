# frozen_string_literal: true

module ProfiledRequestsHelper
  def trace_class(name)
    case name
    when 'sql.active_record'
      'sql'
    when 'render_partial.action_view'
      'render-partial'
    when 'render_template.action_view'
      'render-template'
    when 'process_action.action_controller'
      'process-action'
    when 'rack-profiler.step'
      'step'
    when 'rack-profiler.total_time'
      'total-time'
    else
      'other'
    end
  end
end
