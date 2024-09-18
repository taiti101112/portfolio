# config/importmap.rb
pin "application"
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
pin "@popperjs/core", to: "https://unpkg.com/@popperjs/core@2.11.6/dist/umd/popper.min.js"
pin "@rails/ujs", to: "rails-ujs.js"
pin "@hotwired/turbo-rails", to: "https://cdn.jsdelivr.net/npm/@hotwired/turbo@7.3.0/dist/turbo.es2017-umd.js"
pin "@hotwired/stimulus", to: "https://cdn.jsdelivr.net/npm/@hotwired/stimulus@3.2.1/dist/stimulus.umd.js"

# 全てのコントローラーを自動的にピンする
pin "controllers/application", to: "controllers/application.js"
pin "controllers/hello_controller", to: "controllers/hello_controller.js"
