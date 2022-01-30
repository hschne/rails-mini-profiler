# frozen_string_literal: true

require_relative '../../app/helpers/rails_mini_profiler/application_helper'

module RailsMiniProfiler
  # Wraps functionality to render an interactive badge on top of HTML responses
  #
  # @api private
  class Badge
    include InlineSvg::ActionView::Helpers
    include RailsMiniProfiler::ApplicationHelper
    include Engine.routes.url_helpers

    # @param request_context [RequestContext] The current request context
    # @param configuration [Configuration] The current configuration
    def initialize(request_context, configuration: RailsMiniProfiler.configuration)
      @configuration = configuration
      @profiled_request = request_context.profiled_request
      @original_response = request_context.response
    end

    # Inject the badge into the response
    #
    # @return [ResponseWrapper] The modified response
    def render
      return @original_response unless render_badge?

      modified_response = ResponseWrapper.new([], @original_response.status, @original_response.headers)
      modified_response.write(modified_body)
      modified_response.finish

      @original_response.close if @original_response.respond_to?(:close)

      modified_response
    end

    private

    def render_badge?
      content_type = @original_response.headers['Content-Type']
      unless content_type =~ %r{text/html}
        RailsMiniProfiler.logger.debug("badge not rendered, response has content type #{content_type}")
        return false
      end

      unless @configuration.ui.badge_enabled
        RailsMiniProfiler.logger.debug('badge not rendered, disabled in configuration')
        return false
      end

      true
    end

    # Modify the body of the original response
    #
    # @return String The modified body
    def modified_body
      body = @original_response.body
      index = body.rindex(%r{</body>}i) || body.rindex(%r{</html>}i)
      if index
        body.dup.insert(index, badge_content)
      else
        body
      end
    end

    # Render the badge template
    #
    # @return String The badge HTML content to be injected
    def badge_content
      html = File.read(File.expand_path('../../app/views/rails_mini_profiler/badge.html.erb', __dir__))
      @position = css_position
      template = ERB.new(html)
      template.result(binding)
    end

    # Transform the configuration position into CSS style positions
    #
    # @return String The badge position as CSS style
    def css_position
      case @configuration.ui.badge_position
      when 'top-right'
        'top: 5px; right: 5px;'
      when 'bottom-left'
        'bottom: 5px; left: 5px;'
      when 'bottom-right'
        'bottom: 5px; right: 5px;'
      else
        'top: 5px; left: 5px;'
      end
    end
  end
end
