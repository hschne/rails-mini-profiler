# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  module Storage
    RSpec.describe Redis do
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

      let(:user_id) { 1 }

      subject { Redis.new(record_class, configuration) }

      describe 'save' do

        it('should assign incremental key') do
          first = record_class.new(value: 'first')
          second = record_class.new(value: 'second')

          first_result = subject.save(user_id, first)
          second_result = subject.save(user_id, second)

          expect(1).to eq(first_result.id)
          expect(2).to eq(second_result.id)
        end

        it('should save record to redis') do
          record = record_class.new(value: 'value')

          result = subject.save(user_id, record)

          data = redis.get("rmp:dummy:#{record.id}")
          expect(result.to_json).to eq(data)
        end
      end

      describe 'destroy' do
        it('should delete key') do
          record = record_class.new(value: 'value')
          subject.save(user_id, record)

          subject.destroy(user_id, record.id)

          data = redis.get("rmp:dummy:#{record.id}")
          expect(data).to eq(nil)
        end
      end
    end
  end
end
