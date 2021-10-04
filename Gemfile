# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in rails_mini_profiler.gemspec.
gemspec

group :development do
  gem 'annotate', '~> 3.1'
  gem 'appraisal', '~> 2.4'
  gem 'httparty', '~> 0.20.0', require: false
  gem 'puma', '~> 5.5'
  gem 'rubyzip', '~> 2.3', require: false
end

group :test, :development do
  gem 'activerecord-import', '~> 1.2'
  gem 'jb', '~> 0.8'
  gem 'pry', '~> 0.14'
  gem 'rubocop', '~> 1.21'
  gem 'sqlite3', '~> 1.4'
  gem 'stackprof', '~> 0.2'
end

group :test do
  gem 'rspec-rails', '~> 5.0'
  gem 'simplecov', '~> 0.21'
end
