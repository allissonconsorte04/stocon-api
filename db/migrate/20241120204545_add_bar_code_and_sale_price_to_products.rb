class AddBarCodeAndSalePriceToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :bar_code, :string
    add_column :products, :sale_price, :decimal, precision: 10, scale: 2
  end
end
