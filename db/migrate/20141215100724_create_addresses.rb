class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :zip_code
      t.string :city
      t.string :phone
      t.text :type
      t.text :first_name
      t.text :last_name
      t.references :country, index: true

      t.timestamps
    end
  end
end
