module RailsMiniProfiler
  module Tracing
    class TraceFactory
      class << self
        def create(event)
          kwargs = options(event)
          case event.name
          when 'sql.active_record'
            SequelTrace.new(**kwargs)
          when 'render_template.action_view', 'render_partial.action_view'
            ViewTrace.new(**kwargs)
            event.payload.slice(:identifier, :count)
          when 'process_action.action_controller'
            transform_controller_event(event)
          else
            event.payload
          end
          switch(event.name)
        end

        private

        def self.options(event)
          start = (event.time.to_f * 100_000).to_i
          finish = (event.end.to_f * 100_000).to_i
          kwargs = {
            name: event.name,
            start: start,
            finish: finish,
            duration: finish - start,
            allocations: event.allocations,
            backtrace: Rails.backtrace_cleaner.clean(caller),
            payload: event.payload
          }
        end
      end
    end
  end
end
