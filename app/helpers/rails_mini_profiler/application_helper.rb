# frozen_string_literal: true

module RailsMiniProfiler
  module ApplicationHelper
    def present(model, presenter_class = nil, **)
      klass = presenter_class || "#{model.class}Presenter".constantize
      presenter = klass.new(model, self, **)
      yield(presenter) if block_given?
      presenter
    end

    def icon(name, **kwargs)
      root = RailsMiniProfiler::Engine.root
      icon_path = File.read(root.join('app', 'assets', 'images', "#{name}.svg"))

      Nokogiri::HTML::DocumentFragment.parse(icon_path)
        .at_css('svg')
        .tap { _1['class'] = kwargs[:class] }
        .to_html
        .html_safe
    end

    def pagination_links(pagination, path_params = {})
      return '' unless pagination.show_pagination?

      links = []
      current_params = request.query_parameters.except('page')
      links << build_previous_link(pagination, current_params, path_params)
      links.concat(build_page_links(pagination, current_params, path_params))
      links << build_next_link(pagination, current_params, path_params)

      content_tag(:div, links.join(' ').html_safe, class: 'pagination')
    end

    private

    def build_previous_link(pagination, current_params, path_params)
      if pagination.has_previous?
        prev_params = current_params.merge(page: pagination.previous_page)
        link_to('← Previous', path_params.merge(prev_params), class: 'pagination-link pagination-prev')
      else
        '<span class="pagination-link pagination-prev disabled">← Previous</span>'.html_safe
      end
    end

    def build_page_links(pagination, current_params, path_params)
      pagination.page_range.map do |p|
        build_page_link(p, pagination, current_params, path_params)
      end
    end

    def build_page_link(page_num, pagination, current_params, path_params)
      if page_num == '...'
        "<span class='pagination-link pagination-ellipsis'>#{page_num}</span>".html_safe
      elsif page_num == pagination.page
        "<span class='pagination-link pagination-current'>#{page_num}</span>".html_safe
      else
        page_params = current_params.merge(page: page_num)
        link_to(page_num, path_params.merge(page_params), class: 'pagination-link')
      end
    end

    def build_next_link(pagination, current_params, path_params)
      if pagination.has_next?
        next_params = current_params.merge(page: pagination.next_page)
        link_to('Next →', path_params.merge(next_params), class: 'pagination-link pagination-next')
      else
        '<span class="pagination-link pagination-next disabled">Next →</span>'.html_safe
      end
    end
  end
end
