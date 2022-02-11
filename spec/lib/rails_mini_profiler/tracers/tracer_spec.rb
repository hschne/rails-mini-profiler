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

          Tracer.new(@event)
        end

        it('stores starts and ends as milliseconds') do
          expect(subject.trace.duration).to be_within(5).of(@event.duration * 100)
        end

        it('stores start and ends as microseconds') do
          expect(subject.trace.start).to be_within(100).of(@event.time.to_f * Tracer::TIMESTAMP_MULTIPLIER)
          expect(subject.trace.finish).to be_within(100).of(@event.end.to_f * Tracer::TIMESTAMP_MULTIPLIER)
        end
      end
    end
  end
end
