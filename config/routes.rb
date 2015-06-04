Rails.application.routes.draw do
  root 'rounds#index'
  resources :rounds, only: [:show]
end
