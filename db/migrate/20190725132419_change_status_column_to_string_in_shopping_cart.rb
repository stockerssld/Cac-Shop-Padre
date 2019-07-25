class ChangeStatusColumnToStringInShoppingCart < ActiveRecord::Migration[5.2]
  def change
    change_column :shopping_carts, :status, nil 
  end
end
