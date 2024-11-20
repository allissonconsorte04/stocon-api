class Sale < ApplicationRecord
  belongs_to :user # O usuário (vendedor) que fez a venda
  has_many :sale_items # Itens da venda
  has_many :products, through: :sale_items # Produtos vendidos nesta venda

  # Calcula o valor total da venda
  after_commit :calculate_total_amount

  private

  def calculate_total_amount
    update_column(:total_amount, sale_items.sum(&:total_price)) # Atualiza o valor diretamente no banco
  end
end
