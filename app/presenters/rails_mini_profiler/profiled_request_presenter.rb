# frozen_string_literal: true

module RailsMiniProfiler
  class ProfiledRequestPresenter < BasePresenter
    def request_name
      model.request_path
    end

    def duration
      formatted_duration(model.duration)
    end

    def allocations
      formatted_allocations(model.allocations)
    end

    def created_at
      from_time = Time.now
      created_at = model.created_at.in_time_zone(Time.zone)
      distance = if from_time - created_at < 5.minutes
                   'Now'
                 else
                   "#{distance_of_time_in_words(from_time, created_at)} ago"
                 end
      time_tag(created_at) { content_tag('span', distance) }
    end

    def flamegraph_button
      return nil unless RailsMiniProfiler.configuration.flamegraph_enabled

      return nil unless model.flamegraph.present?

      link_to(flamegraph_path(model.id), title: 'Show Flamegraph') do
        content_tag('button', 'Flamegraph', class: 'btn-grey')
      end
    end
  end
end
