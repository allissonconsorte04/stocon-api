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

  def sales_and_products_by_date
    # Captura de parâmetros
    start_date = params[:start_date].to_date
    end_date = params[:end_date].to_date

    # Filtra os dados dentro do intervalo
    filtered_sales = Sale.where(created_at: start_date.beginning_of_day..end_date.end_of_day)
    filtered_products = Product.where(created_at: start_date.beginning_of_day..end_date.end_of_day)

    render json: {
      sales: {
        count: filtered_sales.count,
        total_value: filtered_sales.sum(:total_amount)
      },
      products: {
        count: filtered_products.count,
        total_value: filtered_products.sum('price * quantity')
      }
    }
  rescue ArgumentError
    render json: { error: 'Invalid date format. Use YYYY-MM-DD.' }, status: :unprocessable_entity
  end
end
