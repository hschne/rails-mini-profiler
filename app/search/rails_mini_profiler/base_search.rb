# frozen_string_literal: true

module RailsMiniProfiler
  class BaseSearch
    def initialize(params = nil, **kwargs)
      config = self.class.config
      options = params.to_h
      options = options.merge(kwargs)
      @scope = options.delete(:scope) || (config[:scope] && instance_eval(&config[:scope]))
      @options = (options.delete(:options) || config[:options]).stringify_keys
      @params = options.stringify_keys.slice(*@options.keys)
    end

    def results
      @results ||= apply
    end

    def results?
      results.any?
    end

    class << self
      def scope(&block)
        config[:scope] = block
      end

      def option(name, options = {}, &block)
        name = name.to_s
        handler = options[:with] || block

        config[:options][name] = normalize_search_handler(handler, name)

        define_method(name) { @search.param name }
      end

      def results(**)
        new(**).results
      end

      def config
        @config ||= { options: {} }
      end

      private

      def normalize_search_handler(handler, name)
        case handler
        when Symbol
          ->(scope, value) { method(handler).call scope, value }
        when Proc
          handler
        else
          ->(scope, value) { scope.where name => value unless value.blank? }
        end
      end
    end

    private

    def apply
      @params.inject(@scope) do |scope, (name, value)|
        new_scope = instance_exec scope, value, &@options[name]
        new_scope || scope
      end
    end
  end
end
