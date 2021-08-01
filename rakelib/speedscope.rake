# frozen_string_literal: true

namespace :speedscope do
  desc 'Update Speedscope to the latest version'
  task :update do
    require_relative 'util/speedscope'

    Speedscope.update($stdout)
  end
end
