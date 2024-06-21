Rails.application.routes.draw do
  get 'dashboard/index'
  resources :payments
  devise_for :users

  resources :debts, except: %i(edit update show)

  resources :people do
    collection do
      get :search
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'reports/balance'
  # Defines the root path route ("/")
  root 'dashboard#index'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

end
