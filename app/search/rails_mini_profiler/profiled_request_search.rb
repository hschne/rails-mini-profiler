# frozen_string_literal: true

module RailsMiniProfiler
  class ProfiledRequestSearch < BaseSearch
    option(:id) do |scope, value|
      scope.where(id: value)
    end

    option(:path) do |scope, value|
      scope.where('request_path LIKE ?', "%#{value}%")
    end

    option(:method) do |scope, value|
      scope.where(request_method: value)
    end

    option(:media_type) do |scope, value|
      scope.where(response_media_type: value)
    end

    option(:status) do |scope, value|
      value = value.map(&:to_i)
      min = value.min
      max = value.max + 100
      scope.where('response_status >= :lower', lower: min)
        .where('response_status < :upper', upper: max)
    end

    option(:duration) do |scope, value|
      scope.where('duration > :duration', duration: value)
    end
  end
end
