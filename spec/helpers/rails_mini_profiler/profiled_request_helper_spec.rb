# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe ProfiledRequestsHelper do
    describe 'formatted duration' do
      context 'less than 1 ms' do
        it 'shows decimal ' do
          expect(helper.formatted_duration(99)).to eq(0.99)
        end
      end

      context 'more than 1 ms' do
        it 'returns rounded ' do
          expect(helper.formatted_duration(111)).to eq(1)
        end
      end
    end

    describe 'formatted allocations' do
      context 'less than 1000' do
        it 'returns plain number' do
          expect(helper.formatted_allocations(100)).to eq('100')
        end
      end

      context 'with thousands' do
        it 'returns formatted number' do
          expect(helper.formatted_allocations(5_500)).to eq('5.5 k')
        end
      end

      context 'with millions' do
        it 'returns formatted number' do
          expect(helper.formatted_allocations(5_500_500)).to eq('5.5 M')
        end
      end

      context 'with billions' do
        it 'returns formatted number' do
          expect(helper.formatted_allocations(5_500_500_500)).to eq('5.5 B')
        end
      end

      context 'with trillions' do
        it 'returns formatted number' do
          expect(helper.formatted_allocations(5_500_500_500_500)).to eq('5.5 T')
        end
      end
    end
  end
end
