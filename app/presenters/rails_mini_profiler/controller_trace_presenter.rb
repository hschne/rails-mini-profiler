# frozen_string_literal: true

module RailsMiniProfiler
  class ControllerTracePresenter < TracePresenter
    def label
      'Action Controller'
    end

    def payload

      content_tag('div') do
        content_tag('pre', class: 'trace-payload') do
          content_tag(:div, "View Time: #{model.view_runtime} ms, DB Time: #{model.db_runtime} ms", class: 'sequel-trace-query')
        end
      end
    end
  end
end
