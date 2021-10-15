# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  RSpec.describe DatabaseAdapter, type: :model do
    describe 'cast column' do
      context 'default' do
        it 'returns original column' do
          expect(described_class.cast_to_text(:column)).to equal(:column)
        end
      end

      context 'postgres' do
        it 'returns original column' do
          expect(ActiveRecord::Base.connection).to receive(:adapter_name).and_return('PostgreSQL')

          expect(described_class.cast_to_text(:column)).to eq('column::text')
        end
      end
    end
  end
end
