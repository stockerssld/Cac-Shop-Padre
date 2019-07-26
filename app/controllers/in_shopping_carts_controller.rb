class InShoppingCartsController < ApplicationController
    
    def create
        in_shopping_cart = InShoppingCart.new(product_id: params[:product_id], 
                                                                shopping_cart: @shopping_cart)
                                                                
        if in_shopping_cart.save
            redirect_to carrito_path, notice:"guardamos el producto en tu carrito de compras"
        else
            redirect_to products_path(id: params[:product_id]), notice: "No pudimos guardar su producto en el carrito de compras"
        end
    end

    def destroy
        @in_shopping_cart = InShoppingCart.find(params[:id])
        @in_shopping_cart.destroy

        redirect_to carrito_path
        
    end
end