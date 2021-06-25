# frozen_string_literal: true

module RailsMiniProfiler
  module Storage
    class ActiveRecordStore < RecordStore
      def initialize(record_type, configuration = nil)
        super
        key = "#{record_type.name.demodulize.underscore}_table"
        table = @storage_options.public_send(key)
        @record_class = clazz.demodulize
      end

      def all
        @record_class.all
      end

      def find(id)
        find_record(id)
      end

      def find_many(*ids)
        @record_class.where(id: ids)
      end

      def create(record)
        @record_class.create(record.to_h)
      end

      def update(record)
        find_record(record.id).update(record.to_h)

        record
      end

      def destroy(id)
        find_record(id).destroy

        id
      end

      def clear
        @record_class.destroy_all
      end

      private

      def find_record(id)
        @record_class.find(id)
      rescue ActiveRecord::RecordNotFound
        raise(RecordNotFound, "Record with id='#{id}' not found")
      end
    end
  end
end
