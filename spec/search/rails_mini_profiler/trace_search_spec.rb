# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe TraceSearch, type: :model do
    describe 'search' do
      let(:profiled_request) { ProfiledRequest.create(request_path: '/index') }

      context 'by name' do
        it 'returns traces with matching name' do
          trace = Trace.create(name: 'sql', profiled_request: profiled_request)
          Trace.create(name: 'other', profiled_request: profiled_request)

          results = described_class.results(scope: Trace.all, name: 'sql')

          expect(results).to eq([trace])
        end
      end

      context ' by allocations' do
        it 'returns traces with greater allocation' do
          request = Trace.create(allocations: 101, profiled_request: profiled_request)
          Trace.create(allocations: 100, profiled_request: profiled_request)

          results = described_class.results(scope: Trace.all, allocations: 100)

          expect(results).to eq([request])
        end
      end

      context 'by duration' do
        it 'returns traces with greater duration' do
          request = Trace.create(duration: 10_001, profiled_request: profiled_request)
          Trace.create(duration: 10_000, profiled_request: profiled_request)

          results = described_class.results(scope: Trace.all, duration: 10_000)

          expect(results).to eq([request])
        end
      end

      context 'by payload' do
        it 'returns traces with matching payload' do
          profiled_request.traces.create(payload: { sample: 'one' })
          trace = profiled_request.traces.create(payload: { sample: 'two here' })

          results = described_class.results(scope: Trace.all, payload: 'two')

          expect(results).to eq([trace])
        end
      end
    end
  end
end
