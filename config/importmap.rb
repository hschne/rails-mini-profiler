pin 'application', to: 'rails_mini_profiler/application.js', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from MissionControl::Jobs::Engine.root.join('app/javascript/rails_mini_profiler/controllers'),
             under: 'controllers',
             to: 'mission_control/jobs/controllers'
