class AddOneAddrToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :one_address, :integer
  end
end
