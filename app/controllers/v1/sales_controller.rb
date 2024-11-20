class V1::SalesController < ApplicationController
  def index
    @sales = Sale.includes(:sale_items, :user).all

    render json: @sales.to_json(
      include: {
        sale_items: {
          include: {
            product: {
              only: [:name, :price]
            }
          },
          only: [:quantity, :unit_price, :total_price]
        },
        user: {
          only: [:id, :name]
        }
      },
      except: [:updated_at]
    )
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.sale_date = DateTime.now

    # Inicia a transação para garantir a integridade dos dados
    ActiveRecord::Base.transaction do
      @sale.save!

      # Criar os itens da venda
      sale_items_params.each do |item_param|
        product = Product.find(item_param[:product_id])
        @sale.sale_items.create!(
          product: product,
          quantity: item_param[:quantity],
          unit_price: product.price,
          total_price: item_param[:quantity] * product.price
        )
      end
    end

    render json: @sale, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def sale_params
    params.require(:sale).permit(:user_id)
  end

  def sale_items_params
    params.require(:sale_items).map do |item|
      item.permit(:product_id, :quantity)
    end
  end
end
