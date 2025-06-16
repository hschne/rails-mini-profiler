# frozen_string_literal: true

module RailsMiniProfiler
  class Pagination
    attr_reader :page, :page_size, :total_count, :total_pages

    def initialize(collection, page:, page_size:)
      @collection = collection
      @page_size = page_size
      @page = [page, 1].max
      @total_count = @collection.count
      @total_pages = (@total_count.to_f / @page_size).ceil
      @page = [@page, @total_pages].min if @total_pages.positive?
    end

    def paginate
      result = @collection.limit(@page_size).offset(offset)
      [self, result]
    end

    def offset
      (page - 1) * @page_size
    end

    def has_previous?
      page > 1
    end

    def has_next?
      page < total_pages
    end

    def previous_page
      has_previous? ? page - 1 : nil
    end

    def next_page
      has_next? ? page + 1 : nil
    end

    def show_pagination?
      total_pages > 1
    end

    def page_range
      return (1..total_pages).to_a if total_pages <= 7

      if page_near_start?
        start_section_range
      elsif page_near_end?
        end_section_with_ellipsis
      else
        middle_section_with_ellipsis
      end
    end

    private

    def page_near_start?
      page <= 4
    end

    def page_near_end?
      page >= total_pages - 3
    end

    def start_range
      [1]
    end

    def end_range
      [total_pages]
    end

    def middle_ellipsis
      ['...']
    end

    def end_section_range
      ((total_pages - 4)..total_pages).to_a
    end

    def start_section_range
      (1..5).to_a + middle_ellipsis + end_range
    end

    def end_section_with_ellipsis
      start_range + middle_ellipsis + end_section_range
    end

    def middle_section_with_ellipsis
      start_range + middle_ellipsis + middle_section_range + middle_ellipsis + end_range
    end

    def middle_section_range
      ((page - 1)..(page + 1)).to_a
    end
  end
end
