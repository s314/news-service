Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  get 'news', action: 'index', controller: 'news'
  get 'news/stats', action: 'stats', controller: 'news'
  get 'news/:category', action: 'index', controller: 'news'
  root to: 'home#index'
  # Auth
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
end
