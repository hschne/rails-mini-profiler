# frozen_string_literal: true

require 'rails_helper'
require 'ostruct'

module RailsMiniProfiler
  module Tracers
    RSpec.describe TraceFactory do
      let(:configuration) { Configuration.new }

      let(:registry) { Registry.new(configuration) }

      subject { described_class.new(registry) }

      describe 'create' do
        it('should return a trace with unknown event') do
          event = OpenStruct.new(name: 'unknown')

          expect(subject.create(event)).to be_a(Trace)
        end
      end
    end
  end
end
