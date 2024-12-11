Rails.application.routes.draw do
  devise_for :users
  resources :messages, only: %i[index create]
  root 'messages#index'
end
