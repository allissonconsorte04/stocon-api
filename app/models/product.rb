class Product < ApplicationRecord
  has_many :inventories_products
  has_many :inventories, through: :inventories_products

  belongs_to :category
  belongs_to :supplier

  # Método para reduzir o estoque
  def reduce_stock!(quantity)
    if self.quantity >= quantity
      self.quantity -= quantity
      save!
    else
      raise "Estoque insuficiente para o produto #{name}"
    end
  end
end
