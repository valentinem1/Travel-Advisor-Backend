Rails.application.routes.draw do
  resources :add_joiners
  resources :things_to_dos
  resources :bucketlists
  resources :reviews
  resources :destinations
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
