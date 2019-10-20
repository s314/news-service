Rails.application.routes.draw do

  # News
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

  # Entries
  resources :read_later_entries, only: [:index, :create, :destroy]
  resources :learning_entries, only: [:index, :create, :destroy]

end
