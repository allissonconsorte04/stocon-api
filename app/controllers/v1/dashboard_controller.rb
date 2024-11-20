class V1::DashboardController < ApplicationController
  def index
    # Cálculo dos dados para o dashboard
    total_products = Product.count
    total_product_value = Product.sum('price * quantity')

    total_sales = Sale.count
    total_sales_value = Sale.sum(:total_amount)

    render json: {
      products: {
        count: total_products,
        total_value: total_product_value
      },
      sales: {
        count: total_sales,
        total_value: total_sales_value
      }
    }
  end
end
