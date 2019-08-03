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

  def payment_succed
    if @shopping_cart.payed?
      cookies[:shopping_cart_id] = nil
    else
      redirect_to carrito_path
    end
  end
end