class WelcomeController < ApplicationController
  def index
  end

  def unregistered
    @products = Product.all
  end

  def admin
    render layout: "admin"
  end

  def about
        
  end
end