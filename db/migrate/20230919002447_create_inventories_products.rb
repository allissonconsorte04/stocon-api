class CreateInventoriesProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :inventories_products do |t|
      t.references :inventory, foreign_key: true
      t.references :product, foreign_key: true
    end
  end
end
