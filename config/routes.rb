Rails.application.routes.draw do
  # get 'attachments/create'
  # get 'attachments/destroy'
  # get 'attachments/new'
  # get 'welcome/index'
  # get 'welcome/unregistered'
  # get 'welcome/admin'
  # get 'welcome/admin'
  resources :attachments, only: [:create,:destroy, :new]
  resources :products
  devise_for :users
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
