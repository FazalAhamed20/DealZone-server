Rails.application.routes.draw do
  get "search/index"
  get "search/my_product_search"
  resources :session, controller: "sessions", only: [ :create ]
  delete '/logout', to: 'sessions#destroy'

  resources :users, controller: "users", only: [ :create ]
  resources :products do
    collection do
      get :my_products
      get :search_categories
    end
  end

end
