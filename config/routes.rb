Rails.application.routes.draw do
  namespace :v1 do
    resources :inventories
    resources :products
    resources :users
    resources :roles
    resources :categories
  end
end
