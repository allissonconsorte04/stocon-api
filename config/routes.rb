Rails.application.routes.draw do
  get '/health', to: 'healthcheck#index'
  namespace :v1 do
    post '/login', to: 'auth#login'
    resources :suppliers
    resources :inventories
    resources :products
    resources :users
    resources :roles
    resources :categories
    resources :sales
  end
end
