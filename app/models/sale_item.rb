class SaleItem < ApplicationRecord
  belongs_to :sale # A venda à qual este item pertence
  belongs_to :product # O produto que foi vendido

  # Calcula o total do item (quantidade * preço unitário)
  before_save :calculate_total_price

  # Reduz o estoque quando o item de venda for criado
  after_create :reduce_product_stock

  private

  def calculate_total_price
    self.total_price = quantity * unit_price
  end

  def reduce_product_stock
    product.reduce_stock!(quantity) # Reduz a quantidade em estoque do produto
  end
end
