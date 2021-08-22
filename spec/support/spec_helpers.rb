# frozen_string_literal: true

module SpecHelpers
  def response_json
    JSON.parse(response.body)
  end
end
