# frozen_string_literal: true

require 'rails_helper'
require 'ostruct'

module RailsMiniProfiler
  module Tracers
    RSpec.describe ControllerTracer do
      describe 'trace' do
        let(:payload) { { view_runtime: 10, db_runtime: 5, ignore: 100 } }
        let(:event) { OpenStruct.new(payload: payload) }

        subject { ControllerTracer.new(event) }

        it('should remove payload fields') do
          trace = subject.trace
          expected = { view_runtime: 10, db_runtime: 5 }
          expect(trace.payload).to eq(expected)
        end

        context 'with blank values' do
          let(:payload) { { view_runtime: '', db_runtime: 5 } }

          it('should remove blank values') do
            trace = subject.trace
            expected = { db_runtime: 5 }
            expect(trace.payload).to eq(expected)
          end
        end

        context 'with numbers' do
          let(:payload) { { view_runtime: 10.105 } }

          it('should round to two digits') do
            trace = subject.trace
            expected = { view_runtime: 10.11 }
            expect(trace.payload).to eq(expected)
          end
        end
      end
    end
  end
end
