# frozen_string_literal: true

require_relative 'lib/rails_mini_profiler/version'

Gem::Specification.new do |spec|
  spec.name = 'rails_mini_profiler'
  spec.version = RailsMiniProfiler::VERSION
  spec.authors = ['hschne']
  spec.email = ['hans.schnedlitz@gmail.com']

  spec.summary = 'Performance profiling for your Rails app, made simple'
  spec.description = 'Performance profiling for your Rails app, made simple'
  spec.homepage = 'https://github.com/hschne/rails-mini-profiler'
  spec.license = 'MIT'

  spec.metadata = {
    'bug_tracker_uri' => "#{spec.homepage}/issues",
    'changelog_uri' => "#{spec.homepage}/blob/main/CHANGELOG.md",
    'documentation_uri' => spec.homepage.to_s,
    'homepage_uri' => spec.homepage.to_s,
    'source_code_uri' => spec.homepage.to_s
  }

  spec.files = Dir['{app,config,db,lib,public}/**/*', 'vendor/assets/**/*', 'LICENSE', 'README.md']

  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.0')

  spec.add_dependency 'inline_svg', '~> 1.7'
  spec.add_dependency 'jb', '~> 0.8'
  spec.add_dependency 'pagy', '>= 4.11', '< 6.0'
  spec.add_dependency 'rails', '>= 6.0'
end
