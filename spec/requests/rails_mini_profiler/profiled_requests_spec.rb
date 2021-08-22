# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe '/profiled_requests', type: :request do
    let(:user_id) { '127.0.0.1' }

    describe 'GET /index' do
      it 'renders a successful response' do
        profiled_request = ProfiledRequest.create(user_id: user_id)

        get profiled_requests_url

        expect(response_json.dig(0, 'id')).to eq(profiled_request.id)
      end

      context 'with search' do
        it 'with matching item returns successful' do
          profiled_request = ProfiledRequest.create(user_id: user_id, request_path: '/first/second')
          ProfiledRequest.create(user_id: user_id, request_path: '/first/third')

          get profiled_requests_url(path: 'second')

          result = response_json
          expect(result.size).to eq(1)
          expect(result.dig(0, 'id')).to eq(profiled_request.id)
        end
      end

      context 'with pagination' do
        before(:each) do
          Pagy::VARS[:items] = 2
        end

        after(:each) do
          Pagy::VARS[:items] = 40
        end

        it 'with stored items returns items' do
          profiled_request = ProfiledRequest.create(user_id: user_id)
          ProfiledRequest.create(user_id: user_id)
          ProfiledRequest.create(user_id: user_id)

          get profiled_requests_url(page: 2)

          expect(response_json.dig(0, 'id')).to eq(profiled_request.id)
        end
      end
    end

    describe 'GET /show' do
      it 'without item redirects and shows error' do
        get profiled_request_url(-1)

        expect(response).to be_not_found
      end

      it 'with stored item returns successful' do
        profiled_request = ProfiledRequest.create(user_id: user_id)

        get profiled_request_url(profiled_request.id)

        expect(response_json['id']).to eq(profiled_request.id)
      end

      context 'with search' do
        it 'with traces returns successful' do
          profiled_request = ProfiledRequest.create(user_id: user_id)
          profiled_request.traces.create(payload: { sample: 'one' })
          trace = profiled_request.traces.create(payload: { sample: 'two' })

          get profiled_request_url(profiled_request.id, search: 'two')

          expect(response_json.dig('traces', 0, 'id')).to eq(trace.id)
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested profiled_request' do
        profiled_request = ProfiledRequest.create(user_id: user_id)

        delete profiled_request_url(profiled_request)

        expect(ProfiledRequest.exists?(profiled_request.id)).to be(false)
      end
    end
  end
end
