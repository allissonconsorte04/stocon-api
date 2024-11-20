Rails.application.routes.draw do
  get '/health', to: 'healthcheck#index'
  namespace :v1 do
    post '/login', to: 'auth#login'
    resources :suppliers
    resources :inventories
    resources :products do
      collection do
        get 'find_by_bar_code/:bar_code', to: 'products#find_by_bar_code'
      end
    end
    resources :users
    resources :roles
    resources :categories
    resources :sales
    get '/dashboard', to: 'dashboard#index'
  end
end
