# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  module Tracers
    RSpec.describe Tracer do
      describe 'trace' do
        let(:event) { OpenStruct.new }

        subject { Tracer.new(event) }

        it('should return a trace') do
          expect(subject.trace).to be_a(Trace)
        end
      end
    end
  end
end
