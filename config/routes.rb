Rails.application.routes.draw do
  resources :attachments, only: [:create,:destroy, :new, :show]
  resources :products
  resources :in_shopping_carts, only: [:create, :destroy]
  devise_for :users

  get "/carrito", to: "shopping_carts#show"
  get "/add/:product_id", as: :add_to_cart, to: "in_shopping_carts#create"
  
  post "/pagar", to: "payments#create"
  get "/checkout", to: "payments#checkout"

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
