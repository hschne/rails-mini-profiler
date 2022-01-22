# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  module Tracers
    RSpec.describe Registry do
      let(:configuration) { Configuration.new }

      subject { described_class.new(configuration) }

      describe 'tracers' do
        it('should return a name to tracer class mapping') do
          result = {
            'instantiation.active_record' => RailsMiniProfiler::Tracers::InstantiationTracer,
            'process_action.action_controller' => RailsMiniProfiler::Tracers::ControllerTracer,
            'render_partial.action_view' => RailsMiniProfiler::Tracers::ViewTracer,
            'rails_mini_profiler.total_time' => RailsMiniProfiler::Tracers::RmpTracer,
            'render_template.action_view' => RailsMiniProfiler::Tracers::ViewTracer,
            'sql.active_record' => RailsMiniProfiler::Tracers::SequelTracer
          }
          expect(subject.tracers).to eq(result)
        end
      end

      describe 'presenters' do
        it('should return a name to presenter class mapping') do
          result = {
            'instantiation.active_record' => RailsMiniProfiler::InstantiationTracePresenter,
            'process_action.action_controller' => RailsMiniProfiler::ControllerTracePresenter,
            'rails_mini_profiler.total_time' => RailsMiniProfiler::RmpTracePresenter,
            'render_partial.action_view' => RailsMiniProfiler::RenderPartialTracePresenter,
            'render_template.action_view' => RailsMiniProfiler::RenderTemplateTracePresenter,
            'sql.active_record' => RailsMiniProfiler::SequelTracePresenter
          }

          expect(subject.presenters).to eq(result)
        end
      end
    end
  end
end
