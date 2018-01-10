Rails.application.routes.draw do

  # Static Pages
  root 'static#index'
  get 'about' => 'static#about', as: "about"
  get 'contact_us' => 'static#contact_us', as: "contact_us"

  # Clearance Default Routes
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Omniauth + Users
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  resources :users, only: [:show, :edit, :update, :destroy]

  # Listings
  resources :listings do
    resources :reservations, only: [:index, :create]
  end

  resources :reservations, only: [:destroy] do # do this? 
    member do
      get 'braintree/new'
      post 'braintree/checkout'
    end
  end

  get "/reservations/:id" => "reservations#show"

end
