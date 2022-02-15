Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'bookmarks#index'
  resources :bookmarks
  resources :users
  resources :friends
end
