# frozen_string_literal: true

module RailsMiniProfiler
  module Repositories
    module Trace
      class TraceRepository < Repositories::TraceRepository
        def initialize
          super
          @record = RailsMiniProfiler::Trace
        end

        def all
          @record.all
        end

        def find(id)
          all.find(id)
        end

        def find_by(**kwargs)
          all.where(**kwargs)
        end

        def create(trace)
          @record.create(trace.to_h)
        end

        def destroy(request_id)
          find(request_id).destroy(request_id)
        end

        def clear
          all.destroy_all
        end
      end
    end
  end
end
