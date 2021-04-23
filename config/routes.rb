# frozen_string_literal: true

RailsMiniProfiler::Engine.routes.draw do
  resources :profiled_requests, only: [:index, :show, :destroy]
end
