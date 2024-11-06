class Sale < ApplicationRecord
  belongs_to :user # O usuário (vendedor) que fez a venda
  has_many :sale_items # Itens da venda
  has_many :products, through: :sale_items # Produtos vendidos nesta venda

  # Calcula o valor total da venda
  before_save :calculate_total_amount

  private

  def calculate_total_amount
    self.total_amount = sale_items.sum(&:total_price) # Calcula a soma dos preços totais dos itens
  end
end
