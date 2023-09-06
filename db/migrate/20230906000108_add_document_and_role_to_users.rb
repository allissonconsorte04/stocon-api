class AddDocumentAndRoleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :document, :string
    add_reference :users, :role, foreign_key: true
  end
end
