# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe '/profiled_requests', type: :request do
    let(:user_id) { '127.0.0.1' }

    describe 'GET /index' do
      it 'renders a successful response' do
        ProfiledRequest.create(user_id: user_id, request_method: 'GET', duration: 0)

        get profiled_requests_url

        expect(response).to be_successful
      end
    end

    describe 'GET /show' do
      it 'without item redirects and shows error' do
        get profiled_request_url(-1)

        expect(flash[:alert]).to be_present
      end

      it 'with stored item return successful' do
        profiled_request = ProfiledRequest.create(user_id: user_id, request_method: 'GET', duration: 0)

        get profiled_request_url(profiled_request.id)

        expect(response).to be_successful
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
