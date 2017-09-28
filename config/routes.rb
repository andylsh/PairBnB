Rails.application.routes.draw do
  resources :passwords, controller: "passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :edit, :update, :show, :destroy] do
    resource :password,
      controller: "passwords",
      only: [:create, :edit, :update]
      resources :listings, only: [:show]
  end

  resources :listings, except: [:show] do
    resources :reservations, only: [:new, :create ] 
  end

  resources :reservations, only: [:destroy, :index]

  resources :reservations, only: [:show] 

  root  "pages#home"
  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get 'tags/:tag', to: 'listings#index', as: :tag
  get 'braintree/new'
  post 'braintree/checkout'

  # post 'reservations/:id/braintree/checkout'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end

