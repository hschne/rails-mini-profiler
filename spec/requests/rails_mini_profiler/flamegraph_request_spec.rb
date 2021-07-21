# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe 'Flamegraphs', type: :request do
    let(:user_id) { '127.0.0.1' }

    describe 'GET /show' do
      it 'returns http success' do
        profiled_request = ProfiledRequest.create(user_id: user_id)
        Flamegraph.create(profiled_request: profiled_request, data: {})

        get flamegraph_path(profiled_request.id)

        expect(response).to have_http_status(:success)
      end
    end
  end
end
