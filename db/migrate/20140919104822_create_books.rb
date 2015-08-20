class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.float :price
      t.integer :stock
      t.references :author, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
