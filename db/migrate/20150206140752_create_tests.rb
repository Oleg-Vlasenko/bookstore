class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :name
      t.references :billing_address, index: true
      t.references :shipping_address, index: true

      t.timestamps
    end
  end
end