# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  module Tracing
    RSpec.describe SqlTracker do
      describe 'trace' do
        let(:query) { 'select' }
        let(:name) { 'name' }

        subject { SqlTracker.new(query: query, name: name) }

        context 'with untracked command' do
          let(:query) { 'ignore' }

          it('should not track') do
            expect(subject.track?).to eq(false)
          end
        end

        context 'with untracked name' do
          let(:name) { 'schema' }

          it('should not track') do
            expect(subject.track?).to eq(false)
          end
        end

        context 'with untracked table' do
          let(:query) { 'select * from sqlite_version' }

          it('should not track') do
            expect(subject.track?).to eq(false)
          end
        end
      end
    end
  end
end
