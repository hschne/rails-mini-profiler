# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe TracePresenter, type: :model do
    let(:view_context) { ProfiledRequestsController.new.view_context }
    let(:trace) { Trace.new }
    let(:context) { { start: 0, finish: 0, total_duration: 0, total_allocations: 0 } }
    subject { TracePresenter.new(trace, view_context, context: context) }

    describe 'label' do
      it 'is empty' do
        expect(subject.label).to be_empty
      end
    end

    describe 'description' do
      it 'is empty' do
        expect(subject.description).to be_empty
      end
    end

    describe 'backtrace' do
      let(:trace) { Trace.new(backtrace: {}) }

      context 'with empty backtrace' do
        it 'is nil' do
          expect(subject.backtrace).to be_nil
        end
      end

      context 'with backtrace' do
        let(:trace) { Trace.new(backtrace: { first: 'first_value', second: 'second_value' }) }

        it 'is first entry' do
          expect(subject.backtrace).to eq(%w[first first_value])
        end
      end
    end

    describe 'type' do
      it 'returns css class name' do
        expect(subject.type).to eq('trace')
      end
    end

    describe 'duration' do
      let(:trace) { Trace.new(duration: 1000) }

      it 'returns formatted duration' do
        expect(subject.duration).to eq(10)
      end
    end

    describe 'duration percent' do
      let(:context) { { start: 0, finish: 0, total_duration: 10_000, total_allocations: 0 } }

      let(:trace) { Trace.new(duration: 1_000) }

      it 'returns percent' do
        expect(subject.duration_percent).to eq(10)
      end
    end

    describe 'allocations' do
      let(:trace) { Trace.new(allocations: 1_100) }

      it 'returns percent' do
        expect(subject.allocations).to eq('1.1 k')
      end
    end

    describe 'allocations percent' do
      let(:context) { { start: 0, finish: 0, total_duration: 0, total_allocations: 10_000 } }
      let(:trace) { Trace.new(allocations: 1_000) }

      it 'returns percent' do
        expect(subject.allocations_percent).to eq(10)
      end
    end

    describe 'from start' do
      let(:context) { { start: 0 } }
      let(:trace) { Trace.new(start: 2000) }

      it 'returns difference' do
        expect(subject.from_start).to eq(20)
      end
    end

    describe 'from start percent' do
      let(:context) { { start: 0, finish: 10_000, total_duration: 0, total_allocations: 0 } }
      let(:trace) { Trace.new(start: 2000, finish: 4000) }

      it 'returns percentage difference' do
        expect(subject.from_start).to eq(20)
      end
    end
  end
end
