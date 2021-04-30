require 'rails_helper'

RSpec.describe "Flamegraphs", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/flamegraph/show"
      expect(response).to have_http_status(:success)
    end
  end

end
