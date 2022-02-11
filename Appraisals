# frozen_string_literal: true

appraise 'rails-6.0' do
  gem 'rails', '~> 6.0.0'

  group :test, :development do
    remove_gem 'sprockets-rails'
  end
end

appraise 'rails-6.1' do
  gem 'rails', '~> 6.1.0'
  group :test, :development do
    remove_gem 'sprockets-rails'
  end
end

appraise 'rails-7.0' do
  gem 'rails', '~> 7.0.0'
end
