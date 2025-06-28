# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe 'Application', type: :request do
    after(:each) { User.current_user = nil }

    describe 'POST /movie' do
      let(:default_params) { { format: :json } }

      let(:params) { { movie: { title: 'name' } }.merge(default_params) }

      it 'creates a profiled request ' do
        post(movies_url, params: params)

        expect(response).to be_redirect

        expect(ProfiledRequest.exists?(request_path: '/movies')).to be(true)
      end

      it 'saves request data' do
        post(movies_url, params: params)

        expect(response).to be_redirect

        profiled_request = ProfiledRequest.find_by(request_path: '/movies')
        expect(profiled_request.request_method).to eq('POST')
        expect(profiled_request.request_query_string).to eq('')
        expect(profiled_request.request_body).to eq('movie[title]=name&format=json')
      end

      it 'saves performance data' do
        events = []
        ActiveSupport::Notifications.subscribe('rails_mini_profiler.total_time') do |event|
          events << event
        end

        post(movies_url, params: params)

        expect(response).to be_redirect
        trace = events.first
        profiled_request = ProfiledRequest.find_by(request_path: '/movies')
        trace_start = trace.time.to_f * Tracers::Tracer::TIMESTAMP_MULTIPLIER
        trace_end = trace.time.to_f * Tracers::Tracer::TIMESTAMP_MULTIPLIER
        expect(profiled_request.start * 1000).to be_within(10_000).of(trace_start)
        expect(profiled_request.finish * 1000).to be_within(10_000).of(trace_end)
        expect(profiled_request.duration).to be_within(10_000).of(trace.duration * 100)
        expect(profiled_request.allocations).to be_within(10_000).of(trace.allocations)
      end

      it 'saves response data' do
        post(movies_url, params: params)

        expect(response).to be_redirect

        profiled_request = ProfiledRequest.find_by(request_path: '/movies')
        expect(profiled_request.response_status).to eq(302)
        expect(profiled_request.response_headers['content-type']).to eq('text/html; charset=utf-8')
        expect(profiled_request.response_media_type).to eq('text/html')
      end
    end

    describe 'GET /rails_mini_profiler' do
      context 'in development' do
        it 'with user returns successful' do
          User.authorize('127.0.0.1')

          get rails_mini_profiler_url

          expect(response).to be_successful
        end

        it 'without user returns successful' do
          get rails_mini_profiler_url

          expect(response).to be_successful
        end
      end

      context 'in production' do
        before(:each) { allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('production')) }

        it 'without user redirects to root' do
          get rails_mini_profiler_url

          expect(response).to redirect_to('/')
        end

        it 'with user returns successful' do
          User.authorize('127.0.0.1')

          get rails_mini_profiler_url

          expect(response).to be_successful
        end
      end
    end
  end
end
