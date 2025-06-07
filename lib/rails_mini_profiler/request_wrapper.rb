# frozen_string_literal: true

module RailsMiniProfiler
  # A convenience wrapper extending {Rack::Request}
  #
  # @api private
  class RequestWrapper < Rack::Request
    # Convenience method to read the request body as String
    #
    # @return [String] the request body
    def body
      input = super
      return '' unless input

      # Store current position
      current_pos = input.pos if input.respond_to?(:pos)

      # Rewind to beginning to read full content
      input.rewind if input.respond_to?(:rewind)
      body_content = input.read

      # Restore position
      if current_pos && input.respond_to?(:seek)
        input.seek(current_pos)
      elsif input.respond_to?(:rewind)
        input.rewind
      end

      body_content || ''
    rescue StandardError => e
      # If we can't read the body, return empty string
      RailsMiniProfiler.logger.debug("Failed to read request body: #{e.message}")
      ''
    end

    # The request headers
    #
    # @return [Hash] the request headers
    def headers
      env.select { |k, _v| k.start_with? 'HTTP_' } || {}
    end
  end
end
