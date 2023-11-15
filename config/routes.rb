Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "dashboard", to: "pages#dashboard"

  resources :stocks, only: [:index, :show, :update]
  get '/api', to: 'stocks#api'
  post '/update_stock_price/:index', to: 'stocks#price_update'
  post '/buy_stock/:id', to: 'stocks#buy_stock', as: 'buy_stock'
  delete '/sell_stock/:id', to: 'stocks#sell_stock', as: 'sell_stock'

end
