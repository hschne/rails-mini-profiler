# frozen_string_literal: true

module RailsMiniProfiler
  class ControllerTracePresenter < TracePresenter
    def label
      'Action Controller'
    end

    def view_runtime
      payload['view_runtime']
    end

    def db_runtime
      payload['db_runtime']
    end

    def content
      content_tag('div') do
        content_tag('pre', class: 'trace-payload') do
          content_tag(:div, "View Time: #{view_runtime} ms, DB Time: #{db_runtime} ms",
                      class: 'sequel-trace-query')
        end
      end
    end
  end
end
