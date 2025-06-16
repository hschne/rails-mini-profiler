# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe Pagination do
    let(:collection) { double('collection') }

    describe '#initialize' do
      context 'with basic parameters' do
        before do
          allow(collection).to receive(:count).and_return(50)
        end

        it 'initializes with valid parameters' do
          pagination = Pagination.new(collection, page: 2, page_size: 10)

          expect(pagination.page).to eq(2)
          expect(pagination.page_size).to eq(10)
          expect(pagination.total_count).to eq(50)
          expect(pagination.total_pages).to eq(5)
        end
      end

      context 'with negative page number' do
        before do
          allow(collection).to receive(:count).and_return(50)
        end

        it 'sets page to 1 when given negative number' do
          pagination = Pagination.new(collection, page: -5, page_size: 10)

          expect(pagination.page).to eq(1)
        end
      end

      context 'with zero page number' do
        before do
          allow(collection).to receive(:count).and_return(50)
        end

        it 'sets page to 1 when given zero' do
          pagination = Pagination.new(collection, page: 0, page_size: 10)

          expect(pagination.page).to eq(1)
        end
      end

      context 'with page number exceeding total pages' do
        before do
          allow(collection).to receive(:count).and_return(25)
        end

        it 'sets page to last page when exceeding total' do
          pagination = Pagination.new(collection, page: 10, page_size: 10)

          expect(pagination.page).to eq(3)
          expect(pagination.total_pages).to eq(3)
        end
      end

      context 'with empty collection' do
        before do
          allow(collection).to receive(:count).and_return(0)
        end

        it 'handles empty collection correctly' do
          pagination = Pagination.new(collection, page: 1, page_size: 10)

          expect(pagination.page).to eq(1)
          expect(pagination.total_count).to eq(0)
          expect(pagination.total_pages).to eq(0)
        end
      end

      context 'with single item collection' do
        before do
          allow(collection).to receive(:count).and_return(1)
        end

        it 'calculates total pages correctly' do
          pagination = Pagination.new(collection, page: 1, page_size: 10)

          expect(pagination.total_pages).to eq(1)
        end
      end
    end

    describe '#paginate' do
      let(:paginated_collection) { double('paginated_collection') }

      before do
        allow(collection).to receive(:count).and_return(50)
        allow(collection).to receive(:limit).with(10).and_return(collection)
        allow(collection).to receive(:offset).with(20).and_return(paginated_collection)
      end

      it 'returns pagination object and paginated collection' do
        pagination = Pagination.new(collection, page: 3, page_size: 10)
        result_pagination, result_collection = pagination.paginate

        expect(result_pagination).to eq(pagination)
        expect(result_collection).to eq(paginated_collection)
      end
    end

    describe '#offset' do
      before do
        allow(collection).to receive(:count).and_return(50)
      end

      it 'calculates offset for page 1' do
        pagination = Pagination.new(collection, page: 1, page_size: 10)

        expect(pagination.offset).to eq(0)
      end

      it 'calculates offset for page 3' do
        pagination = Pagination.new(collection, page: 3, page_size: 10)

        expect(pagination.offset).to eq(20)
      end

      it 'calculates offset with different page size' do
        pagination = Pagination.new(collection, page: 2, page_size: 25)

        expect(pagination.offset).to eq(25)
      end
    end

    describe 'navigation methods' do
      before do
        allow(collection).to receive(:count).and_return(50)
      end

      describe '#has_previous?' do
        it 'returns false for first page' do
          pagination = Pagination.new(collection, page: 1, page_size: 10)

          expect(pagination.has_previous?).to be(false)
        end

        it 'returns true for pages after first' do
          pagination = Pagination.new(collection, page: 3, page_size: 10)

          expect(pagination.has_previous?).to be(true)
        end
      end

      describe '#has_next?' do
        it 'returns true when not on last page' do
          pagination = Pagination.new(collection, page: 3, page_size: 10)

          expect(pagination.has_next?).to be(true)
        end

        it 'returns false for last page' do
          pagination = Pagination.new(collection, page: 5, page_size: 10)

          expect(pagination.has_next?).to be(false)
        end
      end

      describe '#previous_page' do
        it 'returns nil for first page' do
          pagination = Pagination.new(collection, page: 1, page_size: 10)

          expect(pagination.previous_page).to be_nil
        end

        it 'returns previous page number' do
          pagination = Pagination.new(collection, page: 3, page_size: 10)

          expect(pagination.previous_page).to eq(2)
        end
      end

      describe '#next_page' do
        it 'returns next page number when available' do
          pagination = Pagination.new(collection, page: 3, page_size: 10)

          expect(pagination.next_page).to eq(4)
        end

        it 'returns nil for last page' do
          pagination = Pagination.new(collection, page: 5, page_size: 10)

          expect(pagination.next_page).to be_nil
        end
      end
    end

    describe '#show_pagination?' do
      it 'returns false for single page' do
        allow(collection).to receive(:count).and_return(5)
        pagination = Pagination.new(collection, page: 1, page_size: 10)

        expect(pagination.show_pagination?).to be(false)
      end

      it 'returns true for multiple pages' do
        allow(collection).to receive(:count).and_return(25)
        pagination = Pagination.new(collection, page: 1, page_size: 10)

        expect(pagination.show_pagination?).to be(true)
      end

      it 'returns false for empty collection' do
        allow(collection).to receive(:count).and_return(0)
        pagination = Pagination.new(collection, page: 1, page_size: 10)

        expect(pagination.show_pagination?).to be(false)
      end
    end

    describe '#page_range' do
      context 'with 7 or fewer pages' do
        before do
          allow(collection).to receive(:count).and_return(50)
        end

        it 'returns all pages when total pages <= 7' do
          pagination = Pagination.new(collection, page: 3, page_size: 10)

          expect(pagination.page_range).to eq([1, 2, 3, 4, 5])
        end
      end

      context 'with many pages' do
        before do
          allow(collection).to receive(:count).and_return(200)
        end

        context 'when page is near start (page <= 4)' do
          it 'returns start section with ellipsis' do
            pagination = Pagination.new(collection, page: 2, page_size: 10)

            expect(pagination.page_range).to eq([1, 2, 3, 4, 5, '...', 20])
          end
        end

        context 'when page is near end (page >= total_pages - 3)' do
          it 'returns end section with ellipsis' do
            pagination = Pagination.new(collection, page: 18, page_size: 10)

            expect(pagination.page_range).to eq([1, '...', 16, 17, 18, 19, 20])
          end
        end

        context 'when page is in middle' do
          it 'returns middle section with ellipses on both sides' do
            pagination = Pagination.new(collection, page: 10, page_size: 10)

            expect(pagination.page_range).to eq([1, '...', 9, 10, 11, '...', 20])
          end
        end
      end

      context 'with exactly 8 pages' do
        before do
          allow(collection).to receive(:count).and_return(80)
        end

        it 'shows start section when on early pages' do
          pagination = Pagination.new(collection, page: 3, page_size: 10)

          expect(pagination.page_range).to eq([1, 2, 3, 4, 5, '...', 8])
        end

        it 'shows end section when on later pages' do
          pagination = Pagination.new(collection, page: 6, page_size: 10)

          expect(pagination.page_range).to eq([1, '...', 4, 5, 6, 7, 8])
        end
      end
    end
  end
end
