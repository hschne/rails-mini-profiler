# frozen_string_literal: true

require 'rails_helper'

module RailsMiniProfiler
  module Storage
    RSpec.describe MemoryStore do
      let(:record_class) { Dummies::DummyRecord }

      subject { MemoryStore.new(record_class) }

      describe 'all' do
        it 'should return all records' do
          first = record_class.new(value: 'first')
          second = record_class.new(value: 'second')

          subject.create(first)
          subject.create(second)

          expect(subject.all.size).to eq(2)
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

      describe 'save' do
        it('should assign incremental key') do
          first = record_class.new(value: 'first')
          second = record_class.new(value: 'second')

          first_result = subject.create(first)
          second_result = subject.create(second)

          expect(1).to eq(first_result.id)
          expect(2).to eq(second_result.id)
        end

        it('should save record') do
          record = record_class.new(value: 'value')

          result = subject.create(record)

          data = subject.find(result.id)
          expect(result.to_json).to eq(data.to_json)
        end
      end

      describe 'update' do
        it('should update existing record') do
          record = record_class.new(value: 'value')

          subject.create(record)

          record.value = 'new value'
          subject.update(record)

          expect(subject.find(record.id).value).to eq('new value')
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

          expect(subject.all).to be_empty
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
