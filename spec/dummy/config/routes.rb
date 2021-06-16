# frozen_string_literal: true

Rails.application.routes.draw do
  resources :movies
  mount RailsMiniProfiler::Engine => '/profiler'
end
