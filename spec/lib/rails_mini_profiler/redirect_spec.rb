# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe Redirect do
    describe 'render' do
      let(:env) { {} }
      let(:request) { RequestWrapper.new(env) }
      let(:configuration) { Configuration.new }
      let(:profiled_request) { ProfiledRequest.new(id: 1) }
      let(:request_context) { RequestContext.new(request) }

      subject { Redirect.new(request_context) }

      before(:each) { request_context.profiled_request = profiled_request }

      context 'with flamegraph parameter' do
        let(:env) { { 'QUERY_STRING' => 'rmp_flamegraph=true' } }

        it('should redirect to flamegraph path') do
          expect(subject.render.first).to eq(302)
          expect(subject.render.last).to eq(['Moved Temporarily'])
        end
      end

      context 'without parameter' do
        it('should return false') do
          expect(subject.render).to be(false)
        end
      end
    end
  end
end
