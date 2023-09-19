class Inventory < ApplicationRecord
  has_many :inventories_products
  has_many :products, through: :inventories_products
end
