class PaymentsController < ApplicationController
  include PayPal::SDK::REST

  def checkout
      @my_payment = MyPayment.find_by(paypal_id: params[:paymentId])
        if @my_payment.nil?
          redirect_to "/carrito"
        else
        
          payment = Payment.find(@my_payment.paypal_id)
          
          if payment.execute(payer_id: params[:PayerID])
            # @my_payment.pay!
            redirect_to carrito_path, notice: "Se proceso el pago con paypal"
          else
            redirect_to carrito_path, notice: "Hubo un error al procesar el pago"
          end
        end
  end

  
  def create
    payment = Payment.new({
      :intent =>  "sale",
      :payer =>  {
        :payment_method =>  "paypal" },
      :redirect_urls => {
        :return_url => "http://192.168.0.109:3000//checkout",
        :cancel_url => "http://192.168.0.109:3000/" },
      :transactions =>  [{
        :item_list => {
          :items => [{
            :name => "item",
            :sku => :item,
            :price =>  (@shopping_cart.total),
            :currency => "MXN",
            :quantity => 1 }]},
        :amount =>  {
          :total =>  @shopping_cart.total,
          :currency =>  "MXN" },
        :description =>  "This is the payment transaction description." }]})
    
    if payment.create
      @my_payment = MyPayment.create!(paypal_id: payment.id,
                                  ip: request.remote_ip,
                                shopping_cart_id: cookies[:shopping_cart_id])
      redirect_to payment.links.find{|v| v.method =="REDIRECT"}.href
    else
      
      redirect_to root_url,  notice: payment.error
    #   redirect_to payment.links.find{|v| v.method =="REDIRECT"}.href
      # raise  payment.error.to_yaml
    end
  end
end
