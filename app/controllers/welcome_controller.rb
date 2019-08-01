class WelcomeController < ApplicationController
  def index
    @products = Product.all
  end

  def unregistered
    @products = Product.all
  end

  def admin
    render layout: "admin"
  end

  def about
        
  end
  def contactanos
  end
end