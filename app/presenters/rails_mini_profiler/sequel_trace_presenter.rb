# frozen_string_literal: true

module RailsMiniProfiler
  class SequelTracePresenter < TracePresenter
    def label
      sql_description
    end

    def name
      payload['name']
    end

    def sql
      payload['sql']
    end

    def binds
      payload['binds']
    end

    alias description label

    def content
      return nil if transaction?

      content_tag('div') do
        content_tag('pre', class: 'trace-payload') do
          content_tag(:div, sql, class: 'sequel-trace-query')
        end + binding_content
      end
    end

    private

    def transaction?
      model.payload['name'] == 'TRANSACTION'
    end

    def schema?
      model.payload['name'] == 'SCHEMA'
    end

    def sql_description
      if transaction?
        transaction_description
      elsif schema?
        'Load Schema'
      elsif model.payload['name'].present?
        model.payload['name']
      else
        model.payload['sql'].truncate(15)
      end
    end

    def transaction_description
      # The raw SQL is something like 'BEGIN TRANSACTION', and we just turn it into 'Begin Transaction', which is less
      # loud and nicer to look at.
      model.sql.split.map(&:capitalize).join(' ')
    end

    def binding_content
      return nil if simple_binds.empty?

      content = simple_binds.collect do |hash|
        flat = hash.to_a.flatten
        "#{flat.first}=#{flat.second}"
      end
      content_tag(:pre, content.join(', '), class: 'sequel-trace-binds')
    end

    def simple_binds
      return [] if binds.nil? || binds.empty?

      binds.each_with_object({}) do |hash, object|
        name = hash['name']
        value = hash['value']
        object[name] = value
      end
    end
  end
end
