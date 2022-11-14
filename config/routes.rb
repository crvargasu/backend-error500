Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'polygons', to: 'leaseholders#polygons'
      get 'polygon/:id', to: 'leaseholders#polygon'
      resources :admins
      resources :reviews
      resources :rental_agreements
      get 'rental_agreements/user/:id', to: 'rental_agreements#user_rental_agreements'
      get 'rental_agreements/pending/:id', to: 'rental_agreements#pending_rental_agreements'
      put 'rental_agreements/pending/approve', to: 'rental_agreements#approve_rental_agreement'
      delete 'rental_agreements/pending/delete', to: 'rental_agreements#reject_rental_agreement'
      resources :leaseholders
      resources :lessors
      get 'me', to: 'user#me'
    end
  end
  devise_for :users,
              controllers: {
                  sessions: 'users/sessions',
                  registrations: 'users/registrations'
              }
end
