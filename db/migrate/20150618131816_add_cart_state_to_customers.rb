class AddCartStateToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :cart_state, :string
  end
end
