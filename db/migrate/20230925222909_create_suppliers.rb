class CreateSuppliers < ActiveRecord::Migration[5.2]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.text :description
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
