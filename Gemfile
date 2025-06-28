# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in rails_mini_profiler.gemspec.
gemspec

group :development do
  gem 'annotaterb'
  gem 'appraisal'
  gem 'httparty', require: false
  gem 'puma'
  gem 'rubyzip', require: false
end

group :test, :development do
  gem 'activerecord-import'
  gem 'debug'
  gem 'jb'
  gem 'pg'
  gem 'propshaft'
  gem 'rubocop'
  gem 'sqlite3'
  gem 'stackprof'
end

group :test do
  gem 'rspec-rails'
  gem 'simplecov'
end
