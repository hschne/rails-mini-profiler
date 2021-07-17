# frozen_string_literal: true

module RailsMiniProfiler
  class Badge
    include InlineSvg::ActionView::Helpers
    include Engine.routes.url_helpers

    def initialize(request_context)
      @configuration = RailsMiniProfiler.configuration
      @profiled_request = request_context.profiled_request
      @original_response = request_context.response
    end

    def render
      content_type = @original_response.headers['Content-Type']
      return @original_response unless content_type =~ %r{text/html}

      modified_response = Rack::Response.new([], @original_response.status, @original_response.headers)
      modified_response.write(modified_body)
      modified_response.finish

      response = @original_response.response
      response.close if response.respond_to?(:close)

      ResponseWrapper.new(@original_response.status,
                          @original_response.headers,
                          modified_response)
    end

    private

    def modified_body
      body = @original_response.response.body
      index = body.rindex(%r{</body>}i) || body.rindex(%r{</html>}i)
      if index
        body.insert(index, badge_content)
      else
        body
      end
    end

    def badge_content
      html = IO.read(File.expand_path('../../app/views/rails_mini_profiler/badge.html.erb', __dir__))
      @position = css_position
      template = ERB.new(html)
      template.result(binding)
    end

    def css_position
      case RailsMiniProfiler.configuration.badge_position
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
