# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  module Storage
    RSpec.describe RedisRecordStore do
      let(:redis) { MockRedis.new }

      let(:record_class) do
        Class.new do
          attr_accessor :id, :value

          def initialize(**kwargs)
            kwargs.each { |key, value| instance_variable_set("@#{key}", value) }
          end

          def self.name
            'Dummy'
          end
        end
      end

      let(:configuration) { Configuration.new(storage_options: { redis: redis }) }

      subject { RedisRecordStore.new(record_class, configuration) }

      describe 'save' do
        it('should assign incremental key') do
          first = record_class.new(value: 'first')
          second = record_class.new(value: 'second')

          first_result = subject.create(first)
          second_result = subject.create(second)

          expect(1).to eq(first_result.id)
          expect(2).to eq(second_result.id)
        end

        it('should save record to redis') do
          record = record_class.new(value: 'value')

          result = subject.create(record)

          data = subject.find(result.id)
          expect(result.to_json).to eq(data.to_json)
        end
      end

      describe 'find' do
        it 'should raise error if no record' do
          expect { subject.find(-1) }.to raise_error(RecordNotFound)
        end
      end

      describe 'find many' do
        it 'should return empty array if none' do
          expect(subject.find_many(1, 2)).to be_empty
        end

        it 'should return existing values' do
          record = record_class.new(value: 'value')

          subject.create(record)

          results = subject.find_many(-1, record.id)
          expect(results.size).to eq(1)
          expect(results[0].to_json).to eq(record.to_json)
        end
      end

      describe 'destroy' do
        it('should delete item') do
          record = record_class.new(value: 'value')
          subject.create(record)

          subject.destroy(record.id)

          expect { subject.find(record.id) }.to raise_error(RecordNotFound)
        end
      end

      describe 'clear' do
        it 'should reset ids' do
          record = record_class.new(value: 'value')
          subject.create(record)

          subject.clear
          result = redis.get("#{@prefix}:#{@record_prefix}:next-id")
          expect(result).to be_nil
        end

        it 'should clear records' do
          first = record_class.new(value: 'first')
          second = record_class.new(value: 'second')

          subject.create(first)
          subject.create(second)

          subject.clear

          expect { subject.find(first.id) }.to raise_error(RecordNotFound)
          expect { subject.find(second.id) }.to raise_error(RecordNotFound)
        end
      end
    end
  end
end
