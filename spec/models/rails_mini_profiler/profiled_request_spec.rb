# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe ProfiledRequest, type: :model do
    describe 'save' do
      it 'removes request body null bytes' do
        request = ProfiledRequest.new(request_body: "content\000")
        request.save

        expect(request.request_body).to eq('content')
      end

      it 'removes response body null bytes' do
        request = ProfiledRequest.new(response_body: "content\000")
        request.save

        expect(request.response_body).to eq('content')
      end
    end

    describe 'request' do
      let(:env) do
        {
          'rack.input' => StringIO.new('body'),
          'REQUEST_METHOD' => 'GET',
          'PATH_INFO' => '/path',
          'QUERY_STRING' => 'query',
          'HTTP_SAMPLE_HEADER' => 'value'
        }
      end

      let(:request_wrapper) { RequestWrapper.new(env) }

      before(:each) do
        subject.request = request_wrapper
      end

      it 'sets request body' do
        expect(subject.request_body).to eq('body')
      end

      it 'sets request headers' do
        expect(subject.request_headers).to eq({ 'HTTP_SAMPLE_HEADER' => 'value' })
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
      let(:response) do
        ResponseWrapper.new(
          'body',
          200,
          {
            'HTTP_HEADER' => 'header',
            'Content-Type' => 'application/json'
          }
        )
      end

      before(:each) do
        subject.response = response
      end

      it 'sets response body' do
        expect(subject.response_body).to eq('body')
      end

      it 'sets response media type' do
        expect(subject.response_media_type).to eq('application/json')
      end

      it 'sets response headers' do
        expect(subject.response_headers.transform_keys(&:downcase))
          .to eq({ 'http_header' => 'header',
                   'content-type' => 'application/json' })
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
