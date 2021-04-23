# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Request Profiling', type: :request do
  describe 'show' do
    it 'renders the index template' do
      get '/profile'

      expect(response).to have_http_status(:ok)
    end
  end
end
