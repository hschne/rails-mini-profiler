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
    'source_code_uri' => spec.homepage.to_s,
    'rubygems_mfa_required' => 'true'
  }

  spec.files = Dir['{app,config,db,lib,public}/**/*', 'LICENSE', 'README.md']

  spec.required_ruby_version = Gem::Requirement.new('>= 3.2')

  spec.add_dependency 'importmap-rails', '>= 1.2.1'
  spec.add_dependency 'jb'
  spec.add_dependency 'rails', '>= 7.2'
  spec.add_dependency 'stimulus-rails'
  spec.add_dependency 'turbo-rails'
end
