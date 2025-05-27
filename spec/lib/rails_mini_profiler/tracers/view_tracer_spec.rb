# frozen_string_literal: true

require 'rails_helper'
require 'ostruct'

module RailsMiniProfiler
  module Tracers
    RSpec.describe ViewTracer do
      describe 'trace' do
        let(:payload) { { identifier: 'id', count: 5, ignore: 100 } }
        let(:event) { OpenStruct.new(payload: payload) }

        subject { ViewTracer.new(event) }

        it('should remove payload fields') do
          trace = subject.trace
          expected = { identifier: 'id', count: 5 }
          expect(trace.payload).to eq(expected)
        end
      end
    end
  end
end
