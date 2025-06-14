# frozen_string_literal: true

module RailsMiniProfiler
  class PaginationPresenter < BasePresenter
    def links(path_params = {})
      return '' unless model.show_pagination?

      links = []
      current_params = h.request.query_parameters.except('page')
      links << build_previous_link(current_params, path_params)
      links.concat(build_page_links(current_params, path_params))
      links << build_next_link(current_params, path_params)

      h.content_tag(:div, links.join(' ').html_safe, class: 'pagination')
    end

    private

    def build_previous_link(current_params, path_params)
      if model.has_previous?
        prev_params = current_params.merge(page: model.previous_page)
        h.link_to('← Previous', path_params.merge(prev_params), class: 'pagination-link pagination-prev')
      else
        '<span class="pagination-link pagination-prev disabled">← Previous</span>'.html_safe
      end
    end

    def build_page_links(current_params, path_params)
      model.page_range.map do |p|
        build_page_link(p, current_params, path_params)
      end
    end

    def build_page_link(page_num, current_params, path_params)
      if page_num == '...'
        "<span class='pagination-link pagination-ellipsis'>#{page_num}</span>".html_safe
      elsif page_num == model.page
        "<span class='pagination-link pagination-current'>#{page_num}</span>".html_safe
      else
        page_params = current_params.merge(page: page_num)
        h.link_to(page_num, path_params.merge(page_params), class: 'pagination-link')
      end
    end

    def build_next_link(current_params, path_params)
      if model.has_next?
        next_params = current_params.merge(page: model.next_page)
        h.link_to('Next →', path_params.merge(next_params), class: 'pagination-link pagination-next')
      else
        '<span class="pagination-link pagination-next disabled">Next →</span>'.html_safe
      end
    end
  end
end
