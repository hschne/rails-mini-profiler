# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsMiniProfiler::Engine => '/rails_mini_profiler'
  resources :movies
end
