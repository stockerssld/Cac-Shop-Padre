Rails.application.routes.draw do
  # get 'payments/create'
  # get 'attachments/create'
  # get 'attachments/destroy'
  # get 'attachments/new'
  # get 'welcome/index'
  # get 'welcome/unregistered'
  # get 'welcome/admin'
  # get 'welcome/admin'
  resources :attachments, only: [:create,:destroy, :new, :show]
  resources :products
  resources :in_shopping_carts, only: [:create, :destroy]
  devise_for :users

  get "/carrito", to: "shopping_carts#show"
  get "/add/:product_id", as: :add_to_cart, to: "in_shopping_carts#create"
  post "/pagar", to: "payments#create"
  get "/checkout", to: "payments#checkout"
  # get 'welcome/index'
  # get 'welcome/unregistered'
  # get "welcome/admin"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated :user do
    root to: "welcome#index"
  end
  authenticated :user do
    root to: "welcome#index"
  end
  unauthenticated :user do
    devise_scope :user do 
      root to: "welcome#unregistered"
    end
  end
end
