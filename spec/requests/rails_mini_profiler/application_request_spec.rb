# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe '/', type: :request do
    let(:storage) { Storage::ActiveRecord }

    before do
      RailsMiniProfiler.configure { |configuration| configuration.storage = storage }
    end

    describe 'GET /index' do
      it 'renders a successful response' do
        get movies_url(1)

        expect(response).to be_successful
      end
    end
  end
end
