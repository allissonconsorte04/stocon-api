class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.references :user, foreign_key: true
      t.datetime :sale_date
      t.decimal :total_amount

      t.timestamps
    end
  end
end
