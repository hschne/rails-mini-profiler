# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe 'Flamegraphs', type: :request do
    let(:configuration) { RailsMiniProfiler.configuration }
    let(:context) { RailsMiniProfiler.context }
    let(:storage) { context.storage_instance }

    let(:profiled_request) { ProfiledRequest.new(request: Request.new, response: Response.new) }
    let(:stored_request) { storage.save(profiled_request) }

    describe 'GET /show' do
      it 'returns http success' do
        get flamegraph_path(stored_request.id)

        expect(response).to have_http_status(:success)
      end
    end
  end
end
