class Stores::Paypal
    include PayPal::SDK::REST
    attr_accessor :payment, :shopping_cart, :return_url, :cancel_url

    
    def initialize(options)
        self.shopping_cart = options[:shopping_cart]
        self.return_url= options[:return_url]
        self.cancel_url= options[:cancel_url]
    end

    def process_payment
    self.payment = Payment.new({
        :intent =>  "sale",
        :payer =>  {
            :payment_method =>  "paypal" },
        :redirect_urls => {
            :return_url => self.return_url,
            :cancel_url => self.cancel_url },
        :transactions =>  [{
            :item_list => {
                :items => self.shopping_cart.items
            },
            :amount =>  {
            :total =>  self.shopping_cart.total,
            :currency =>  "MXN" },
            :description =>  "This is the payment transaction description." }]})
    
        self.payment
    end
    
end