class AddCardStateToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :card_state, :string
  end
end
