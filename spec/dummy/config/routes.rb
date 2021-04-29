# frozen_string_literal: true

Rails.application.routes.draw do
  resources :movies
  mount RailsMiniProfiler::Engine => '/rails_mini_profiler'

  get '/health', to: 'health#ping'
end
