# frozen_string_literal: true

require 'httparty'
require 'zip'

class Speedscope
  REPOSITORY = 'jlfwong/speedscope'

  BASE_DIRECTORY = File.expand_path('../../public/rails_mini_profiler', File.dirname(__FILE__))

  def self.update(stdout)
    new(stdout).update
  rescue StandardError => e
    stdout.puts("Error: #{e.message}")
  end

  def initialize(stdout)
    @stdout = stdout
  end

  def update
    return msg('No new version available') unless new_version_available?

    url = "https://github.com/#{REPOSITORY}/releases/download/v#{latest_version}/speedscope-#{latest_version}.zip"
    msg('Downloading latest...')
    body = HTTParty.get(url, follow_redirects: true).body
    msg('Overwriting existing files...')
    overwrite_speedscope(body)
    msg('Done!')
  end

  private

  def msg(*args)
    @stdout.puts(*args)
  end

  def new_version_available?
    latest_version != current_version
  end

  def latest_version
    @latest_version ||= latest_release[:name].sub('v', '')
  end

  def current_version
    @current_version ||= File.read(File.join(BASE_DIRECTORY, 'speedscope', 'release.txt')).split("\n")[0].split('@')[-1]
  end

  def latest_release
    @latest_release ||=
      begin
        response = HTTParty.get('https://api.github.com/repos/jlfwong/speedscope/releases/latest', format: :plain)
        JSON.parse(response, symbolize_names: true)
      end
  end

  def overwrite_speedscope(body)
    exclude_regex = /#{Regexp.union(%w[perf-vertx-stacks README])}/i
    Zip::File.open_buffer(StringIO.new(body)) do |zip_file|
      zip_file.each do |entry|
        next if entry.name =~ exclude_regex

        dest_path = File.join(BASE_DIRECTORY, entry.name)
        entry.extract(dest_path) { true }
      end
    end
  end
end
