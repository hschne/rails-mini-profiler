# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe Guard do
    describe 'profile?' do
      let(:request) { Request.new({}) }

      subject { Guard.new(request) }

      before do
        RailsMiniProfiler.configuration.reset
      end

      context 'with path' do
        let(:request) { Request.new('REQUEST_PATH' => '/') }

        it('should be true') { expect(subject.profile?).to be(true) }
      end

      context 'with profiler mount path' do
        let(:request) { Request.new('REQUEST_PATH' => '/rails_mini_profiler/1') }

        it('should be false') { expect(subject.profile?).to be(false) }
      end

      context 'with no ignored path' do
        let(:request) { Request.new('REQUEST_PATH' => '/ignored') }

        it('should be true') { expect(subject.profile?).to be(true) }
      end

      context 'with ignored path match' do
        let(:request) { Request.new('REQUEST_PATH' => '/ignored') }

        it('should be false') do
          RailsMiniProfiler.configuration.skip_paths = [/ignored/]

          expect(subject.profile?).to be(false)
        end
      end
    end
  end
end
