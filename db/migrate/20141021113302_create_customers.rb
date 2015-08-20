class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.references :billing_address, index: true
      t.references :shipping_address, index: true

      t.timestamps
    end
  end
end
