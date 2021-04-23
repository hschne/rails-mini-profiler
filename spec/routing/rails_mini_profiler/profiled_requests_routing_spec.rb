# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe ProfiledRequestsController, type: :routing do
    describe 'routing' do
      it 'routes to #index' do
        expect(get: profiled_requests_path)
          .to route_to(controller: 'rails_mini_profiler/profiled_requests', action: 'index')
      end

      it 'routes to #show' do
        expect(get: profiled_request_path(1))
          .to route_to(controller: 'rails_mini_profiler/profiled_requests', action: 'show', id: '1')
      end

      it 'routes to #destroy' do
        expect(delete: profiled_request_path(1))
          .to route_to(controller: 'rails_mini_profiler/profiled_requests', action: 'destroy', id: '1')
      end
    end
  end
end
