module RailsMiniProfiler
  module Tracing
    class SqlTracker
      TRACKED_SQL_COMMANDS = %w[SELECT INSERT UPDATE DELETE].freeze
      UNTRACKED_NAMES = %w[SCHEMA].freeze
      UNTRACKED_TABLES = %w[
        SCHEMA_MIGRATIONS
        SQLITE_MASTER
        ACTIVE_MONITORING_METRICS
        SQLITE_TEMP_MASTER
        SQLITE_VERSION
        AR_INTERNAL_METADATA
      ].freeze

      def initialize(query:, name:)
        @query = query.to_s.upcase
        @name = name.to_s.upcase
      end

      def track?
        query.start_with?(*TRACKED_SQL_COMMANDS) &&
          !name.start_with?(*UNTRACKED_NAMES) &&
          !untracked_tables?
      end

      private

      attr_reader :query, :name

      def untracked_tables?
        UNTRACKED_TABLES.any? { |table| query.include?(table) }
      end
    end
  end
end
