Rails.application.routes.draw do
  root 'rounds#index'
  get 'rounds' => "rounds#find_show"
  resources :rounds, only: [:show]
end
