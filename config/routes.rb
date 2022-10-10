Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :admins
      resources :reviews
      resources :rental_agreements
      resources :leaseholders
      resources :lessors
    end
  end
  devise_for :users,
              controllers: {
                  sessions: 'users/sessions',
                  registrations: 'users/registrations'
              }
end
