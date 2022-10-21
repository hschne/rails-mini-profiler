# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
require 'rails_mini_profiler'

module Dummy
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::MAJOR.to_f.to_s

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = 'Europe/Vienna'
    config.active_record.default_timezone = :local
    # config.eager_load_paths << Rails.root.join("extras")

    config.database = ENV.fetch('DATABASE', :sqlite).to_sym
  end
end
