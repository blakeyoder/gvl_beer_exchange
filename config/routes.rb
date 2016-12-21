Rails.application.routes.draw do

  resources :events
  root to: 'static_pages#landing'
  resources :products, only: [:index]
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
  get '/home', to: 'home#home'

end
