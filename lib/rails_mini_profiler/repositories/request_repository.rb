# frozen_string_literal: true

module RailsMiniProfiler
  class RequestRepository
    def initialize(configuration = RailsMiniProfiler.configuration)
      storage = configuration.storage.new(ProfiledRequest, configuration)
      @request_storage = storage
    end

    def find_by(user_id, **kwargs)
      storage.find_by(user_id, **kwargs)
    end

    def save(user_id, request)
      storage.save(user_id, request)
    end

    def update(request)
      storage.update(request)
    end

    def destroy(request_id)
      storage.destroy(request_id)
    end

    def clear
      storage.clear
    end
  end
end
