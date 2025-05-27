# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe Guard do
    describe 'profile?' do
      let(:env) { {} }
      let(:request) { RequestWrapper.new(env) }
      let(:configuration) { Configuration.new }
      let(:request_context) { RequestContext.new(request) }

      subject { Guard.new(request_context, configuration: configuration) }

      context 'with path' do
        let(:env) { { 'PATH_INFO' => '/' } }

        it('should be true') { expect(subject.profile?).to be(true) }
      end

      context 'with no ignored path' do
        let(:env) { { 'PATH_INFO' => '/ignored' } }

        it('should be true') { expect(subject.profile?).to be(true) }
      end

      context 'with profiler mount path' do
        let(:env) { { 'PATH_INFO' => "/#{Engine.routes.url_helpers.root_path}/1" } }

        it('should be false') { expect(subject.profile?).to be(false) }
      end

      context 'with asset path' do
        let(:env) { { 'PATH_INFO' => '/assets/images/abc' } }

        it('should be false') { expect(subject.profile?).to be(false) }
      end

      context 'with actioncable path' do
        let(:env) { { 'PATH_INFO' => ActionCable.server.config.mount_path } }

        it('should be false') { expect(subject.profile?).to be(false) }
      end

      context 'with ignored path match' do
        let(:env) { { 'PATH_INFO' => '/ignored' } }

        it('should be false') do
          configuration.skip_paths = [/ignored/]

          expect(subject.profile?).to be(false)
        end
      end
    end
  end
end
