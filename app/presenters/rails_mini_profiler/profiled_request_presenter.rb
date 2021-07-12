# frozen_string_literal: true

module RailsMiniProfiler
  class ProfiledRequestPresenter < BasePresenter
    def duration
      formatted_duration(model.duration)
    end

    def allocations
      formatted_allocations(model.allocations)
    end

    def created_at
      time_tag(model.created_at.in_time_zone(Time.zone))
    end

    def flamegraph_icon
      return nil unless model.flamegraph.present?

      link_to(flamegraph_path(model.id), title: 'Show Flamegraph', class: 'flamegraph-button') do
        inline_svg_tag('rails_mini_profiler/graph.svg')
      end
    end

    def flamegraph_button
      return nil unless model.flamegraph.present?

      link_to(flamegraph_path(model.id), title: 'Show Flamegraph', class: 'flamegraph-button') do
        content_tag('button', 'Flamegraph')
      end
    end
  end
end
