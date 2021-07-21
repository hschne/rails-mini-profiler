# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in rails_mini_profiler.gemspec.
gemspec

group :development do
  gem 'annotate', '~> 3.1'
  gem 'guard-livereload', '~> 2.5', require: false
  gem 'puma', '~> 5.2'
  gem 'rubocop', '~> 1.7'
end

group :test, :development do
  gem 'activerecord-import', '~> 1.2'
  gem 'jb', '~> 0.8'
  gem 'pry', '~> 0.1'
  gem 'stackprof','~> 0.2'
  gem 'sqlite3', '~> 1.4'
end

group :test do
  gem 'simplecov'
  gem 'rspec-rails', '~> 4.0'
end
