# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe '/profiled_requests', type: :request do
    let(:configuration) { RailsMiniProfiler.configuration }
    let(:context) { RailsMiniProfiler.context }
    let(:storage) { context.storage_instance }

    let(:profiled_request) { ProfiledRequest.new(request: Request.new, response: Response.new) }
    let(:stored_request) { storage.save(profiled_request) }

    describe 'GET /index' do
      it 'renders a successful response' do
        get profiled_requests_url
        expect(response).to be_successful
      end
    end

    describe 'GET /show' do
      it 'renders a successful response' do
        get profiled_request_url(stored_request.id)
        expect(response).to be_successful
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested profiled_request' do
        delete profiled_request_url(stored_request.id)

        expect(storage.find(profiled_request.id)).to be_nil
      end
    end
  end
end
