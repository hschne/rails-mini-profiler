# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe ProfiledRequest, type: :model do
    describe 'request' do
      let(:request_wrapper) do
        OpenStruct.new(
          body: 'body',
          headers: { header: 'value' },
          method: 'GET',
          path: '/path',
          query_string: 'query'
        )
      end

      before(:each) do
        subject.request = request_wrapper
      end

      it 'sets request body' do
        expect(subject.request_body).to eq('body')
      end

      it 'sets request headers' do
        expect(subject.request_headers).to eq({ 'header' => 'value' })
      end

      it 'sets request method' do
        expect(subject.request_method).to eq('GET')
      end

      it 'sets request path' do
        expect(subject.request_path).to eq('/path')
      end

      it 'sets query string' do
        expect(subject.request_query_string).to eq('query')
      end
    end

    describe 'response' do
      let(:response_wrapper) do
        OpenStruct.new(
          body: 'body',
          media_type: 'application/json',
          headers: { header: 'value' },
          status: 200
        )
      end

      before(:each) do
        subject.response = response_wrapper
      end

      it 'sets response body' do
        expect(subject.response_body).to eq('body')
      end

      it 'sets response media type' do
        expect(subject.response_media_type).to eq('application/json')
      end

      it 'sets response headers' do
        expect(subject.response_headers).to eq({ 'header' => 'value' })
      end

      it 'sets response status' do
        expect(subject.response_status).to eq(200)
      end
    end

    describe 'total time' do
      let(:total_time) do
        OpenStruct.new(
          start: 0,
          finish: 5,
          duration: 10,
          allocations: 100
        )
      end

      before(:each) do
        subject.total_time = total_time
      end

      it 'sets start' do
        expect(subject.start).to eq(0)
      end

      it 'sets finish' do
        expect(subject.finish).to eq(5)
      end

      it 'sets duration' do
        expect(subject.duration).to eq(10)
      end

      it 'sets allocations' do
        expect(subject.allocations).to eq(100)
      end
    end
  end
end
