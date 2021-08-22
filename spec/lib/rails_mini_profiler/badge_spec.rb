# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe Badge do
    describe 'render' do
      let(:request) { RequestWrapper.new({}) }
      let(:original_response) { ResponseWrapper.new }
      let(:profiled_request) { ProfiledRequest.new(id: 1) }
      let(:configuration) { Configuration.new }
      let(:request_context) { RequestContext.new(request) }

      subject { Badge.new(request_context, configuration: configuration) }

      before(:each) do
        request_context.response = original_response
        request_context.profiled_request = profiled_request
      end

      context 'with non-html response' do
        let(:original_response) do
          OpenStruct.new(headers: { 'Content-Type' => 'application/json' })
        end

        it('should return original response') { expect(subject.render).to eq(original_response) }
      end

      context 'with html response' do
        let(:original_response) do
          OpenStruct.new(
            status: 200,
            response: OpenStruct.new(body: 'content'),
            headers: { 'Content-Type' => 'text/html' }
          )
        end

        context 'missing body' do
          it('should return original content') do
            new_body = subject.render.response.body.first
            expect(new_body).to eq('content')
          end
        end

        context 'with badge disabled' do
          let(:configuration) { Configuration.new(ui: UserInterface.new(badge_enabled: false)) }

          let(:original_response) do
            OpenStruct.new(
              status: 200,
              response: OpenStruct.new(body: '<body>content</body>'),
              headers: { 'Content-Type' => 'text/html' }
            )
          end

          it 'should not inject badge' do
            new_body = subject.render.response.body
            expect(new_body).to eq('<body>content</body>')
          end
        end

        context 'with body tag' do
          let(:original_response) do
            OpenStruct.new(
              status: 200,
              response: OpenStruct.new(body: '<body>content</body>'),
              headers: { 'Content-Type' => 'text/html' }
            )
          end

          it 'should inject badge' do
            new_body = subject.render.response.body.first
            expect(new_body).to match(/rails-mini-profiler-badge/)
          end
        end
      end
    end
  end
end
