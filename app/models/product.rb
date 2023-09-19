class Product < ApplicationRecord
  has_many :inventories_products
  has_many :inventories, through: :inventories_products

  belongs_to :category
end
