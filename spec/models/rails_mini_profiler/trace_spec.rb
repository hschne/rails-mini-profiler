# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe Trace, type: :model do
    describe 'find STI class' do
      subject { Trace }

      it 'returns controller trace' do
        expect(subject.find_sti_class('process_action.action_controller'))
          .to eq(RailsMiniProfiler::ControllerTrace)
      end

      it 'returns sequel trace' do
        expect(subject.find_sti_class('sql.active_record'))
          .to eq(RailsMiniProfiler::SequelTrace)
      end

      it 'returns instantiation trace' do
        expect(subject.find_sti_class('instantiation.active_record'))
          .to eq(RailsMiniProfiler::InstantiationTrace)
      end

      it 'returns total time' do
        expect(subject.find_sti_class('rails_mini_profiler.total_time'))
          .to eq(RailsMiniProfiler::RmpTrace)
      end

      it 'returns action view trace' do
        expect(subject.find_sti_class('render_template.action_view'))
          .to eq(RailsMiniProfiler::RenderTemplateTrace)
      end

      it 'returns partial trace' do
        expect(subject.find_sti_class('render_partial.action_view'))
          .to eq(RailsMiniProfiler::RenderPartialTrace)
      end
    end
  end
end
