Rails.application.routes.draw do
  get 'news', action: 'index', controller: 'news'
  get 'news/stats', action: 'stats', controller: 'news'
  get 'news/:category', action: 'index', controller: 'news'
  root to: 'home#index'
end
