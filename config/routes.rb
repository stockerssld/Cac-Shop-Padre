Rails.application.routes.draw do
  devise_for :users
  # get 'welcome/index'
  # get 'welcome/unregistered'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated :user do
    root to: "welcome#index"
  end
  unauthenticated :user do
    devise_scope :user do 
      root to: "welcome#unregistered"
    end
  end
end
