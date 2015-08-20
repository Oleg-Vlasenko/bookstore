class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :completed_date
      t.string :state
      t.integer :shipping
      t.references :customer, index: true
      t.references :credit_card, index: true
      t.references :billing_address, index: true
      t.references :shipping_address, index: true

      t.timestamps
    end
  end
end
