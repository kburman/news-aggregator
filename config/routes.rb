require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  get 'web_article/index'
  get 'web_article/show'
  get 'home/index'

  resource :web_article

  mount Sidekiq::Web, at: '/sidekiq'
end
