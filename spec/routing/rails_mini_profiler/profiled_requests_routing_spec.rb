require "rails_helper"

module RailsMiniProfiler
  RSpec.describe ProfiledRequestsController, type: :routing do
    routes { RailsMiniProfiler::Engine.routes }

    describe "routing" do
      it "routes to #index" do
        expect(get: profiled_request_url).to route_to("rails_mini_profiler/profiled_requests#index")
      end

      it "routes to #show" do
        expect(get: "/profiled_requests/1").to route_to("profiled_requests#show", id: "1")
      end

      it "routes to #destroy" do
        expect(delete: "/profiled_requests/1").to route_to("profiled_requests#destroy", id: "1")
      end
    end
  end
end
