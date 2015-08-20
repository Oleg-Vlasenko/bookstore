class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.float :price
      t.integer :quantity
      t.float :total_sum
      t.references :book, index: true
      t.references :order, index: true

      t.timestamps
    end
  end
end
