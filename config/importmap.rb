# frozen_string_literal: true

pin 'application', to: 'rails_mini_profiler/application.js', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true

# External dependencies
pin '@floating-ui/dom', to: 'https://cdn.jsdelivr.net/npm/@floating-ui/dom@1.7.2/+esm'

pin_all_from RailsMiniProfiler::Engine.root.join('app/javascript/rails_mini_profiler/controllers'),
             under: 'controllers',
             to: 'rails_mini_profiler/controllers'
