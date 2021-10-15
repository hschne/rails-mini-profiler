# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe ProfiledRequestSearch, type: :model do
    describe 'search' do
      context 'path' do
        it 'returns profiled requests with matching path' do
          request = ProfiledRequest.create(request_path: '/index')
          ProfiledRequest.create(request_path: '/home')

          results = ProfiledRequestSearch.results(scope: ProfiledRequest.all, path: 'index')

          expect(results).to eq([request])
        end
      end

      context 'method' do
        it 'returns profiled requests with matching method' do
          request = ProfiledRequest.create(request_method: 'GET')
          ProfiledRequest.create(request_method: 'POST')

          results = ProfiledRequestSearch.results(scope: ProfiledRequest.all, method: ['GET'])

          expect(results).to eq([request])
        end
      end

      context 'media type' do
        it 'returns profiled requests with matching media type' do
          request = ProfiledRequest.create(response_media_type: 'text/html')
          ProfiledRequest.create(response_media_type: 'application/json')

          results = ProfiledRequestSearch.results(scope: ProfiledRequest.all, media_type: 'text/html')

          expect(results).to eq([request])
        end
      end

      context 'status' do
        it 'returns profiled requests with matching status' do
          request = ProfiledRequest.create(response_status: 200)
          ProfiledRequest.create(response_status: 400)

          results = ProfiledRequestSearch.results(scope: ProfiledRequest.all, status: [200])

          expect(results).to eq([request])
        end

        it 'returns profiled requests with status in same range' do
          request = ProfiledRequest.create(response_status: 404)
          ProfiledRequest.create(response_status: 500)

          results = ProfiledRequestSearch.results(scope: ProfiledRequest.all, status: [400])

          expect(results).to eq([request])
        end

        it 'returns profiled requests with multiple status' do
          first = ProfiledRequest.create(response_status: 204)
          second = ProfiledRequest.create(response_status: 404)
          ProfiledRequest.create(response_status: 500)

          results = ProfiledRequestSearch.results(scope: ProfiledRequest.all, status: [200, 400])

          expect(results).to eq([first, second])
        end
      end

      context 'duration' do
        it 'returns profiled requests with greater duration' do
          request = ProfiledRequest.create(duration: 10_001)
          ProfiledRequest.create(duration: 10_000)

          results = ProfiledRequestSearch.results(scope: ProfiledRequest.all, duration: 10_000)

          expect(results).to eq([request])
        end
      end
    end
  end
end
