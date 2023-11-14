Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :stocks, only: [:index, :show, :update]
  get '/api', to: 'stocks#api'
  post '/update_stock_price/:index', to: 'stocks#price_update'

end
