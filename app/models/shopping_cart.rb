# == Schema Information
#
# Table name: shopping_carts
#
#  id         :integer          not null, primary key
#  status     :integer          default("default")
#  ip         :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShoppingCart < ApplicationRecord
    include AASM

    has_many :in_shopping_carts
    has_many :products,  through: :in_shopping_carts


    aasm column:"status" do
        state :created, initial: true
        state :payed
        state :failed

        event :pay do
            after do
                # TODO: mandar archivos que compro usuario

            end
            transitions from: :created, to: :payed
        end
    end

    def total
        products.sum(:pricing)
    end
    
end
