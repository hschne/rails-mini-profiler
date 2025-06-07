# frozen_string_literal: true

require 'rails_helper'
require 'ostruct'

module RailsMiniProfiler
  module Tracers
    RSpec.describe SequelTracer do
      describe 'trace' do
        let(:payload) { { name: 'name', sql: 'select', binds: [], type_casted_binds: [], ignore: 'ignore' } }
        let(:event) { OpenStruct.new(payload: payload) }

        subject { SequelTracer.new(event) }

        context 'with invalid query' do
          let(:payload) { { name: 'name', sql: 'bad' } }

          it('should return null trace') do
            trace = subject.trace
            expect(trace).to be_a(NullTrace)
          end
        end

        it('should remove payload fields') do
          trace = subject.trace
          expected = { name: 'name', sql: 'select', binds: [] }
          expect(trace.payload).to eq(expected)
        end

        context('with callable binds') do
          let(:payload) do
            {
              name: 'name',
              sql: 'select',
              binds: [],
              type_casted_binds: -> { [] }
            }
          end

          it('should create binds') do
            trace = subject.trace
            expected = { name: 'name', sql: 'select', binds: [] }
            expect(trace.payload).to eq(expected)
          end
        end

        context('with binds') do
          let(:payload) do
            {
              name: 'name',
              sql: 'select',
              binds: [OpenStruct.new(name: 'id', value_before_cast: '1')],
              type_casted_binds: [1]
            }
          end

          it('should use type casted binds') do
            trace = subject.trace
            expected = { name: 'name', sql: 'select', binds: [{ name: 'id', value: 1 }] }
            expect(trace.payload).to eq(expected)
          end
        end
      end
    end
  end
end
