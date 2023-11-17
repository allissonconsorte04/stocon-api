class AddCodeToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :code, :string, default: nil
  end
end
