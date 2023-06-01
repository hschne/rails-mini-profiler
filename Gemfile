# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in rails_mini_profiler.gemspec.
gemspec

group :development do
  gem 'annotate', '~> 3.1', github: 'ctran/annotate_models'
  gem 'appraisal', '~> 2.4'
  gem 'httparty', '~> 0.20.0', require: false
  gem 'puma', '~> 6.0'
  gem 'rubyzip', '~> 2.3', require: false
end

group :test, :development do
  gem 'activerecord-import', '~> 1.4'
  gem 'jb', '~> 0.8'
  gem 'pg', '~> 1.5'
  gem 'pry', '~> 0.14'
  gem 'rubocop', '~> 1.39'
  gem 'sprockets-rails'
  gem 'sqlite3', '~> 1.5'
  gem 'stackprof', '~> 0.2'
end

group :test do
  gem 'rspec-rails', '~> 6.0'
  gem 'simplecov', '~> 0.22'
end
