# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe 'Flamegraphs', type: :request do
    let(:user) { '127.0.0.1' }

    let(:context) { RailsMiniProfiler.context }
    let(:repository) { ProfiledRequestRepository.create_repository(user) }

    let(:profiled_request) { ProfiledRequest.new(request: Request.new, response: Response.new) }
    let(:stored_request) { repository.create(profiled_request) }

    describe 'GET /show' do
      it 'returns http success' do
        get flamegraph_path(stored_request.id)

        expect(response).to have_http_status(:success)
      end
    end
  end
end
