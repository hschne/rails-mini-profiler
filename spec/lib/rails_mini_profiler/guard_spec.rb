# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe Guard do
    describe 'profile?' do
      let(:request) { RequestWrapper.new }
      let(:configuration) { Configuration.new }
      let(:request_context) { RequestContext.new(request) }

      subject { Guard.new(request_context, configuration: configuration) }

      context 'with path' do
        let(:request) { RequestWrapper.new(path: '/') }

        it('should be true') { expect(subject.profile?).to be(true) }
      end

      context 'with profiler mount path' do
        let(:request) { RequestWrapper.new(path: "/#{Engine.routes.find_script_name({})}/1") }

        it('should be false') { expect(subject.profile?).to be(false) }
      end

      context 'with no ignored path' do
        let(:request) { RequestWrapper.new(path: '/ignored') }

        it('should be true') { expect(subject.profile?).to be(true) }
      end

      context 'with ignored path match' do
        let(:request) { RequestWrapper.new(path: '/ignored') }

        it('should be false') do
          configuration.skip_paths = [/ignored/]

          expect(subject.profile?).to be(false)
        end
      end
    end
  end
end
