Rails.application.routes.draw do
  mount RailsMiniProfiler::Engine => "/rails_mini_profiler"

  resource :profiles, only: [:show]
end
