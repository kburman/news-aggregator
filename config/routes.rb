require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  root 'web_article#index'
  mount Sidekiq::Web, at: '/sidekiq'

  resources :web_article
end
