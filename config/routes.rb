Rails.application.routes.draw do
  get 'payment/new'
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]
  
  resources :listings do
    resources :bookings
    resources :payment
  end
  
  resources :users do
  resource :password, controller: "clearance/passwords", only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  post "/listings/:id/verify" => "listings#verify", as: "verify"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  root 'welcome#index'
  post 'payment/checkout'
  post '/search' => "listings#search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Clearance.configure do |config|
  config.routes = false
end
