# frozen_string_literal: true

module RailsMiniProfiler
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
