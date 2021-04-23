# frozen_string_literal: true

RSpec.describe ProfilesController do
  describe 'show' do
    it "renders the index template" do

      get :show

      expect(response).to have_http_status(:ok)
    end
  end
end
