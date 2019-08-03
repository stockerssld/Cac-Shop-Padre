class Stores::Paypal
    include PayPal::SDK::REST
    attr_accessor :payment, :total,:items, :return_url, :cancel_url

    
    def initialize(total, items,options={})
        # self.shopping_cart = options[:shopping_cart]
        self.total=total
        self.items=items

        options.each {|clave, valor| instance_variable_set("@#{clave}", valor)}
        
        # self.return_url= options[:return_url]
        # self.cancel_url= options[:cancel_url]
    end

    def payment_options
        {
            :intent =>  "sale",
            :payer =>  {
                :payment_method =>  "paypal" },
            :redirect_urls => {
                :return_url => @return_url,
                :cancel_url => @cancel_url },
            :transactions =>  [{
                :item_list => {
                    :items => self.items
                },
                :amount =>  {
                :total =>  self.total,
                :currency =>  "MXN" },
                :description =>  "This is the payment transaction description." }]
        }
        
    end
    def process_payment
        self.payment = Payment.new(payment_options)
        self.payment
    end

    def process_card(card_data)
        options = payment_options
        options[:payer][:payment_method]= "credit_card"
        options[:payer][:funding_instruments]=[{
            credit_card:{
                type: CreditCardValidator::Validator.card_type(card_data[:number]) ,
                number: card_data[:number] ,
                expire_month: [:expire_month] ,
                expire_year: [:expire_year],
                cvv2: [:cvv2] 
                # firt_name: "",
                # last_name: "" ,
            }
        }]
        self.payment = Payment.new(options)
        self.payment
    end
    

    def self.checkout(payer_id, payment_id, &block)
        payment = Payment.find(payment_id)
        if payment.execute(payer_id: payer_id)
            yield if block_given? 
        end

    end
    
end