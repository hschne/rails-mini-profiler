# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe 'Application', type: :request do
    after(:each) { User.current_user = nil }

    describe 'GET /index' do
      it 'creates a profiled request' do
        get movies_url(1)

        expect(response).to be_successful

        expect(ProfiledRequest.exists?(request_path: '/movies.1')).to be(true)
      end
    end

    describe 'GET /rails_mini_profiler' do
      context 'in development' do
        it 'without user returns successful' do
          User.authorize('127.0.0.1')

          get rails_mini_profiler_url

          expect(response).to be_successful
        end

        it 'without user falls back to provided user' do
          get rails_mini_profiler_url

          expect(User.current_user).to eq('127.0.0.1')
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
