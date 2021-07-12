# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in rails_mini_profiler.gemspec.
gemspec

group :development do
  gem 'annotate'
  gem 'guard-livereload', '~> 2.5', require: false
  gem 'puma', '~> 5.2'
  gem 'rspec-rails', '~> 4.0'
  gem 'rubocop', '~> 1.7'
  gem 'sqlite3', '~> 1.4'
end

group :test, :development do
  gem 'activerecord-import'
  gem 'jb'
  gem 'pry'
  gem 'stackprof'
end

group :test do
  gem 'simplecov'
end

# To use a debugger
