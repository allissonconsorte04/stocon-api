class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :quantity
      t.references :category, foreign_key: true
      t.string :measurement

      t.timestamps
    end
  end
end
