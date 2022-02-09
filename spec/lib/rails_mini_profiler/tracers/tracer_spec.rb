# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  module Tracers
    RSpec.describe Tracer do
      describe 'trace' do
        subject do
          ActiveSupport::Notifications.subscribe('wait') do |*args|
            @event = ActiveSupport::Notifications::Event.new(*args)
          end

          ActiveSupport::Notifications.instrument('wait') do
            sleep 0.001
          end

        it('should return a trace') do
          expect(subject.trace).to be_a(Trace)
          Tracer.new(@event)
        end

        it('stores starts and ends as milliseconds') do
          ms_duration = subject.trace.finish - subject.trace.start
          # if it's within 5, it must be the right order of magnitude
          expect(ms_duration).to be_within(5).of(subject.trace.duration)
          Tracer.new(@event)
        end

        it('stores starts and ends as microseconds') do
          micro_duration = subject.trace.finish - subject.trace.start
          expect(micro_duration).to be_within(10).of(subject.trace.duration * 100)
        end
      end
    end
  end
end
