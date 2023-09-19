class CreateInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :inventories do |t|
      t.references :products, index: true, foreign_key: true
      t.references :users, index: true, foreign_key: true

      t.timestamps
    end
  end
end
