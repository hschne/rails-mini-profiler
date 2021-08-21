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
      time_tag(model.created_at.in_time_zone(Time.zone))
    end

    def flamegraph_icon
      return nil unless RailsMiniProfiler.configuration.flamegraph_enabled

      if model.flamegraph.present?
        link_to(flamegraph_path(model.id), title: 'Show Flamegraph') do
          inline_svg('graph.svg')
        end
      else
        link_to(flamegraph_path(model.id), title: 'No Flamegraph present for this request', class: 'link-disabled') do
          inline_svg('graph.svg')
        end
      end
    end

    def flamegraph_button
      return nil unless RailsMiniProfiler.configuration.flamegraph_enabled

      return nil unless model.flamegraph.present?

      link_to(flamegraph_path(model.id), title: 'Show Flamegraph', class: 'flamegraph-button') do
        content_tag('button', 'Flamegraph')
      end
    end
  end
end
