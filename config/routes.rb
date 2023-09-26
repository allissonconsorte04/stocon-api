Rails.application.routes.draw do
  namespace :v1 do
    post '/login', to: 'auth#login'
    resources :suppliers
    resources :inventories
    resources :products
    resources :users
    resources :roles
    resources :categories
  end
end
