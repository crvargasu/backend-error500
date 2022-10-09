Rails.application.routes.draw do
  devise_for :users
  resources :admins
  resources :reviews
  resources :rental_agreements
  resources :leaseholders
  resources :lessors
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
